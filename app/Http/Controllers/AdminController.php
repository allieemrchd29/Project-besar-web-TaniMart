<?php

namespace App\Http\Controllers;

use App\Models\Label;
use App\Models\Category;
use App\Models\Product;
use App\Models\Coupon;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Transaction;
use App\Models\Slide;
use App\Models\Contact;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\File;
use Intervention\Image\Laravel\Facades\Image;
use Intervention\Image\Drivers\Gd\Driver;

class AdminController extends Controller
{
    public function index()
    {
        $orders = Order::orderBy('created_at','DESC')->get()->take(10);
        $dashboardDatas = DB::select("Select sum(total) as TotalAmount,
                                            sum(if(status='ordered',total,0)) as TotalOrderAmount,
                                            sum(if(status='delivered',total,0)) as TotalDeliveredAmount,
                                            sum(if(status='canceled',total,0)) as TotalCanceledAmount,
                                            Count(*) as Total,
                                            sum(if(status='ordered',1,0)) as TotalOrder,
                                            sum(if(status='delivered',1,0)) as TotalDelivered,
                                            sum(if(status='canceled',1,0)) as TotalCanceled
                                            From Orders
                                            ");

        $monthlyDatas = DB::select("SELECT M.id As MonthNo, M.name As MonthName,
                                            IFNULL(D.TotalAmount,0) As TotalAmount,
                                            IFNULL(D.TotalOrderAmount,0) As TotalOrderAmount,
                                            IFNULL(D.TotalDeliveredAmount,0) As TotalDeliveredAmount,
                                            IFNULL(D.TotalCanceledAmount,0) As TotalCanceledAmount FROM month_names M
                                            LEFT JOIN (Select DATE_FORMAT(created_at, '%b') As MonthName,
                                            MONTH(created_at) As MonthNo,
                                            sum(total) As TotalAmount,
                                            sum(if(status='ordered',total,0)) As TotalOrderAmount,
                                            sum(if(status='delivered',total,0)) As TotalDeliveredAmount,
                                            sum(if(status='canceled',total,0)) As TotalCanceledAmount
                                            From Orders WHERE YEAR(created_at)=YEAR(NOW()) GROUP BY YEAR(created_at), MONTH(created_at), DATE_FORMAT(created_at, '%b')
                                            Order By MONTH(created_at)) D On D.MonthNo=M.id");     
                                            
        $AmountM = implode(',', collect($monthlyDatas)->pluck('TotalAmount')->toArray());
        $OrderAmountM = implode(',', collect($monthlyDatas)->pluck('TotalOrderAmount')->toArray());
        $DeliveredAmountM = implode(',', collect($monthlyDatas)->pluck('TotalDeliveredAmount')->toArray());
        $CanceledAmountM = implode(',', collect($monthlyDatas)->pluck('TotalCanceledAmount')->toArray());

        $TotalAmount = collect($monthlyDatas)->sum('TotalAmount');
        $TotalOrderAmount = collect($monthlyDatas)->sum('TotalOrderAmount');
        $TotalDeliveredAmount = collect($monthlyDatas)->sum('TotalDeliveredAmount');
        $TotalCanceledAmount = collect($monthlyDatas)->sum('TotalCanceledAmount');

        return view('admin.index', compact('orders', 'dashboardDatas', 'AmountM', 'OrderAmountM', 'DeliveredAmountM', 'CanceledAmountM', 'TotalAmount', 'TotalOrderAmount', 'TotalDeliveredAmount', 'TotalCanceledAmount'));
    }

    public function labels()
    {
        $labels = Label::orderBy('id', 'DESC')->paginate(10);
        return view('admin.labels', compact('labels'));
    }

    public function add_label()
    {
        return view('admin.label-add');
    }

    public function label_store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'slug' => 'required|unique:labels,slug',
            'image' => 'mimes:jpg,jpeg,png,gif|max:2048',
        ]);

        $label = new Label();
        $label->name = $request->name;
        $label->slug = Str::slug($request->name);
        $image = $request->file('image');
        $file_extention = $request->file('image')->extension();
        $file_name = Carbon::now()->timestamp.'.'.$file_extention;
        $this->generatedLabelThumbnailsImage($image, $file_name);
        $label->image = $file_name;
        $label->save();

        return redirect()->route('admin.labels')->with('status', 'Label has been added successfully.');
    }

    public function label_edit($id)
    {
        $label = Label::find($id);
        return view('admin.label-edit', compact('label'));
    }

    public function label_update(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'slug' => 'required|unique:labels,slug,'.$request->id,
            'image' => 'mimes:jpg,jpeg,png,gif|max:2048',
        ]);

        $label = Label::find($request->id);
        $label->name = $request->name;
        $label->slug = Str::slug($request->name);
        if ($request->hasFile('image')) {
            if (File::exists(public_path('uploads/labels/').'/'.$label->image)) 
            {
                File::delete(public_path('uploads/labels/').'/'.$label->image);
            }
            $image = $request->file('image');
            $file_extention = $request->file('image')->extension();
            $file_name = Carbon::now()->timestamp.'.'.$file_extention;
            $this->generatedLabelThumbnailsImage($image, $file_name);
            $label->image = $file_name;
        }
        $label->save();
        return redirect()->route('admin.labels')->with('status', 'Label has been updated successfully.');
    }

    public function generatedLabelThumbnailsImage($image, $imageName)
    {
        $destinationPath = public_path('uploads/labels');
        $img = Image::read($image->path());
        $img->cover(124, 124, "top");
        $img->resize(124, 124,function($constraint) {
            $constraint->aspectRatio();
        })->save($destinationPath."/".$imageName);
    }

    public function label_delete($id)
    {
        $label = Label::find($id);
        if (File::exists(public_path('uploads/labels/').'/'.$label->image)) 
        {
            File::delete(public_path('uploads/labels/').'/'.$label->image);
        }
        $label->delete();
        return redirect()->route('admin.labels')->with('status', 'Label has been deleted successfully.');
    }

    public function categories()
    {
        $categories = Category::orderBy('id', 'DESC')->paginate(10);
        return view('admin.categories', compact('categories'));
    }

    public function category_add()
    {
        return view('admin.category-add');
    }

    public function category_store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'slug' => 'required|unique:categories,slug',
            'image' => 'required|mimes:jpg,jpeg,png,gif|max:2048',
        ]);

        $category = new Category();
        $category->name = $request->name;
        $category->slug = Str::slug($request->name);
        $image = $request->file('image');
        $file_extention = $image->extension();
        $file_name = Carbon::now()->timestamp.'.'.$file_extention;
        $this->generatedCategoryThumbnailsImage($image, $file_name);
        $category->image = $file_name;
        $category->save();

        return redirect()->route('admin.categories')->with('status', 'Category has been added successfully.');
    }

    public function generatedCategoryThumbnailsImage($image, $imageName)
    {
        $destinationPath = public_path('uploads/categories');
        $img = Image::read($image->path());
        $img->cover(124, 124, "top");
        $img->resize(124, 124,function($constraint) {
            $constraint->aspectRatio();
        })->save($destinationPath."/".$imageName);
    }

    public function category_edit($id)
    {
        $category = Category::find($id);
        return view('admin.category-edit', compact('category'));
    }

    public function category_update(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'slug' => 'required|unique:categories,slug,'.$request->id,
            'image' => 'mimes:jpg,jpeg,png,gif|max:2048',
        ]);

        $category = Category::find($request->id);
        $category->name = $request->name;
        $category->slug = Str::slug($request->name);
        if ($request->hasFile('image')) {
            if (File::exists(public_path('uploads/categories/').'/'.$category->image)) 
            {
                File::delete(public_path('uploads/categories/').'/'.$category->image);
            }
            $image = $request->file('image');
            $file_extention = $request->file('image')->extension();
            $file_name = Carbon::now()->timestamp.'.'.$file_extention;
            $this->generatedCategoryThumbnailsImage($image, $file_name);
            $category->image = $file_name;
        }
        $category->save();
        return redirect()->route('admin.categories')->with('status', 'Category has been updated successfully.');
    }

    public function category_delete(Request $request)
    {
        $category = Category::find($request->id);
        if (File::exists(public_path('uploads/categories/').'/'.$category->image)) 
        {
            File::delete(public_path('uploads/categories/').'/'.$category->image);
        }
        $category->delete();
        return redirect()->route('admin.categories')->with('status', 'Category has been deleted successfully.');
    }

    public function products()
    {
        $products = Product::orderBy('created_at', 'DESC')->paginate(10);
        return view('admin.products', compact('products'));
    }

    public function product_add()
    {
        $categories = Category::select('id', 'name')->orderBy('name')->get();
        $labels = Label::select('id', 'name')->orderBy('name')->get();
        return view('admin.product-add', compact('categories', 'labels'));
    }

    public function product_store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'slug' => 'required|unique:products,slug',
            'short_description' => 'required',
            'description' => 'required',
            'regular_price' => 'required',
            'sale_price' => 'required',
            'SKU' => 'required|unique:products,SKU',
            'stock_status' => 'required',
            'featured' => 'required',
            'quantity' => 'required',
            'image' => 'required|mimes:jpg,jpeg,png,gif|max:2048',
            'category_id' => 'required',
            'label_id' => 'required',
        ]);

        $product = new Product();
        $product->name = $request->name;
        $product->slug = Str::slug($request->name);
        $product->short_description = $request->short_description;
        $product->description = $request->description;
        $product->regular_price = $request->regular_price;
        $product->sale_price = $request->sale_price;
        $product->SKU = $request->SKU;
        $product->stock_status = $request->stock_status;
        $product->featured = $request->featured;
        $product->quantity = $request->quantity;
        $product->category_id = $request->category_id;
        $product->label_id = $request->label_id;

        $current_timestamp = Carbon::now()->timestamp;

        if ($request->hasFile('image')) 
        {
            $image = $request->file('image');
            $imageName = $current_timestamp.'.'.$image->extension();
            $this->GenerateProductThumbnailsImage($image, $imageName);
            $product->image = $imageName;  
        }

        $gallery_arr = array();
        $gallery_images = "";
        $counter = 1;

        if ($request->hasFile('images')) 
        {
            $allowedFileExtension = ['jpg', 'jpeg', 'png', 'gif'];
            $files = $request->file('images');
            foreach ($files as $file) 
            {
                $gextension = $file->getClientOriginalExtension();
                $gcheck = in_array($gextension, $allowedFileExtension);
                if ($gcheck)
                {
                    $gfileName = $current_timestamp."_".$counter.".".$gextension;
                    $this->GenerateProductThumbnailsImage($file, $gfileName);
                    array_push($gallery_arr, $gfileName);
                    $counter = $counter + 1;
                }
            }
            $gallery_images = implode(",", $gallery_arr);
        }
        $product->images = $gallery_images;
        $product->save();

        return redirect()->route('admin.products')->with('status', 'Product has been added successfully.');
    }

    public function GenerateProductThumbnailsImage($image, $imageName)  
    {
        $destinationPathThumbnail = public_path('uploads/products/thumbnails');
        $destinationPath = public_path('uploads/products');
        $img = Image::read($image->path());

        $img->cover(540, 689, "top");
        $img->resize(540, 689,function($constraint) {
            $constraint->aspectRatio();
        })->save($destinationPath."/".$imageName);

        $img->resize(104, 104,function($constraint) {
            $constraint->aspectRatio();
        })->save($destinationPathThumbnail."/".$imageName);
    }

    public function product_edit($id)
    {
        $product = Product::findOrFail($id);
        $categories = Category::select('id', 'name')->orderBy('name')->get();
        $labels = Label::select('id', 'name')->orderBy('name')->get();
        return view('admin.product-edit', compact('product', 'categories', 'labels'));
    }

    public function product_update(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'slug' => 'required|unique:products,slug,'.$request->id,
            'short_description' => 'required',
            'description' => 'required',
            'regular_price' => 'required',
            'sale_price' => 'required',
            'SKU' => 'required|unique:products,SKU,'.$request->id,
            'stock_status' => 'required',
            'featured' => 'required',
            'quantity' => 'required',
            'image' => 'mimes:jpg,jpeg,png,gif|max:2048',
            'category_id' => 'required',
            'label_id' => 'required',
        ]);
        
        $product = Product::findOrFail($request->id);
        $product->name = $request->name;
        $product->slug = Str::slug($request->name);
        $product->short_description = $request->short_description;
        $product->description = $request->description;
        $product->regular_price = $request->regular_price;
        $product->sale_price = $request->sale_price;
        $product->SKU = $request->SKU;
        $product->stock_status = $request->stock_status;
        $product->featured = $request->featured;
        $product->quantity = $request->quantity;
        $product->category_id = $request->category_id;
        $product->label_id = $request->label_id;
        
        $current_timestamp = Carbon::now()->timestamp;

        if ($request->hasFile('image')) 
        {
            if (File::exists(public_path('uploads/products').'/'.$product->image)) 
            {
                File::delete(public_path('uploads/products').'/'.$product->image);
            }
            if (File::exists(public_path('uploads/products/thumbnails').'/'.$product->image)) 
            {
                File::delete(public_path('uploads/products/thumbnails').'/'.$product->image);
            }

            $image = $request->file('image');
            $imageName = $current_timestamp.'.'.$image->extension();
            $this->GenerateProductThumbnailsImage($image, $imageName);
            $product->image = $imageName;  
        }

        $gallery_arr = array();
        $gallery_images = "";
        $counter = 1;

        if ($request->hasFile('images')) 
        {
            foreach(explode(',', $product->images) as $ofile)
            {
                if (File::exists(public_path('uploads/products').'/'.$ofile)) 
                {
                    File::delete(public_path('uploads/products').'/'.$ofile);
                }
                if (File::exists(public_path('uploads/products/thumbnails').'/'.$ofile)) 
                {
                    File::delete(public_path('uploads/products/thumbnails').'/'.$ofile);
                }
            }

            $allowedFileExtension = ['jpg', 'jpeg', 'png', 'gif'];
            $files = $request->file('images');
            foreach ($files as $file) 
            {
                $gextension = $file->getClientOriginalExtension();
                $gcheck = in_array($gextension, $allowedFileExtension);
                if ($gcheck)
                {
                    $gfileName = $current_timestamp."_".$counter.".".$gextension;
                    $this->GenerateProductThumbnailsImage($file, $gfileName);
                    array_push($gallery_arr, $gfileName);
                    $counter = $counter + 1;
                }
            }
            $gallery_images = implode(",", $gallery_arr);
            $product->images = $gallery_images;
        }
        $product->save();

        return redirect()->route('admin.products')->with('status', 'Product has been updated successfully.');
    }

    public function product_delete($id)
    {
        $product = Product::find($id);
        if (File::exists(public_path('uploads/products/').'/'.$product->image)) 
        {
            File::delete(public_path('uploads/products/').'/'.$product->image);
        }
        if (File::exists(public_path('uploads/products/thumbnails/').'/'.$product->image))
        {
            File::delete(public_path('uploads/products/thumbnails/').'/'.$product->image);
        }

        foreach(explode(',', $product->images) as $ofile)
        {
            if (File::exists(public_path('uploads/products').'/'.$ofile)) 
            {
                File::delete(public_path('uploads/products').'/'.$ofile);
            }
            if (File::exists(public_path('uploads/products/thumbnails').'/'.$ofile)) 
            {
                File::delete(public_path('uploads/products/thumbnails').'/'.$ofile);
            }
        }

        $product->delete();
        return redirect()->route('admin.products')->with('status', 'Product has been deleted successfully.');
    }

    public function coupons()
    {
        $coupons = Coupon::orderBy('created_at','DESC')->paginate(12);
        return view('admin.coupons', compact('coupons'));
    }

    public function coupon_add()
    {
        return view('admin.coupon-add');
    }

    public function coupon_store(Request $request)
    {
        $request->validate([
            'code'=> 'required',
            'type'=> 'required',
            'value'=> 'required|numeric',
            'cart_value'=> 'required|numeric',
            'expiry_date'=> 'required|date',
        ]);

        $coupon = new Coupon();
        $coupon->code = $request->code;
        $coupon->type = $request->type;
        $coupon->value = $request->value;
        $coupon->cart_value = $request->cart_value;
        $coupon->expiry_date = $request->expiry_date;
        $coupon->save();

        return redirect()->route('admin.coupons')->with('status','Coupon has been added successfully');
    }

    public function coupon_edit($id)
    {
        $coupon = Coupon::find($id);
        return view('admin.coupon-edit', compact('coupon'));
    }

    public function coupon_update(Request $request)
    {
        $request->validate([
            'code'=> 'required',
            'type'=> 'required',
            'value'=> 'required|numeric',
            'cart_value'=> 'required|numeric',
            'expiry_date'=> 'required|date',
        ]);

        $coupon = Coupon::find($request->id);
        $coupon->code = $request->code;
        $coupon->type = $request->type;
        $coupon->value = $request->value;
        $coupon->cart_value = $request->cart_value;
        $coupon->expiry_date = $request->expiry_date;
        $coupon->save();

        return redirect()->route('admin.coupons')->with('status','Coupon has been update successfully');
    }

    public function coupon_delete($id)
    {
        $coupon = Coupon::find($id);
        $coupon->delete();
        return redirect()->route('admin.coupons')->with('status','Coupon has been deleted successfully');
    }

    public function orders()
    {
        $orders = Order::orderBy('created_at','DESC')->paginate(12);
        return view('admin.orders', compact('orders'));
    }

    public function order_details($order_id)
    {
        $order = Order::find($order_id);
        $orderItems = OrderItem::where('order_id', $order_id)->orderBy('id')->paginate(12);
        $transaction = Transaction::where('order_id', $order_id)->first();
        return view('admin.order-details', compact('order','orderItems','transaction'));
    }

    public function update_order_status(Request $request)
    {
        $order = Order::find($request->order_id);
        $order->status = $request->order_status;
        if($request->order_status == 'delivered')
        {
            $order->delivered_date = Carbon::now();
        }
        elseif($request->order_status == 'canceled')
        {
            $order->canceled_date = Carbon::now();
        }
        $order->save();

        if($request->order_status == 'delivered')
        {
            $transaction = Transaction::where('order_id', $request->order_id)->first();
            $transaction->status = 'approved';
            $transaction->save();
        }
        return back()->with('status','status changed successfully!');
    }

    public function slides()
    {
        $slides = Slide::orderBy('id', 'DESC')->paginate(12);
        return view('admin.slides', compact('slides'));
    }

    public function slide_add()
    {
        return view('admin.slide-add');
    }

    public function slide_store(Request $request)
    {
        $request->validate([
            'tagline'=> 'required',
            'title'=> 'required',
            'subtitle'=> 'required',
            'link'=> 'required',
            'status'=> 'required',
            'image'=> 'required|mimes:png,jpg,jpeg|max:2048',
        ]);

        $slide = new Slide;
        $slide->tagline = $request->tagline;
        $slide->title = $request->title;
        $slide->subtitle = $request->subtitle;
        $slide->link = $request->link;
        $slide->status = $request->status;
        
        $image = $request->file('image');
        $file_extention = $request->file('image')->extension();
        $file_name = Carbon::now()->timestamp.'.'.$file_extention;
        $this->generatedSlideThumbnailsImage($image, $file_name);
        $slide->image = $file_name;
        $slide->save();
        return redirect()->route('admin-slides')->with('status','Slide added successfully!');
    }

    public function generatedSlideThumbnailsImage($image, $imageName)
    {
        $destinationPath = public_path('uploads/slides');
        $img = Image::read($image->path());
        $img->cover(400, 690, "top");
        $img->resize(400, 690, function($constraint) {
            $constraint->aspectRatio();
        })->save($destinationPath."/".$imageName);
    }

    public function slide_edit($id)
    {
        $slide = Slide::find($id);    
        return view('admin.slide-edit', compact('slide'));
    }

    public function slide_update(Request $request)
    {
        $request->validate([
            'tagline'=> 'required',
            'title'=> 'required',
            'subtitle'=> 'required',
            'link'=> 'required',
            'status'=> 'required',
            'image'=> 'mimes:png,jpg,jpeg|max:2048',
        ]);

        $slide = Slide::find($request->id);
        $slide->tagline = $request->tagline;
        $slide->title = $request->title;
        $slide->subtitle = $request->subtitle;
        $slide->link = $request->link;
        $slide->status = $request->status;
        
        if( $request->hasFile('image') )
        {
            if(File::exists(public_path('uploads/slides').'/'.$slide->image))
            {
                File::delete(public_path('uploads/slides').'/'.$slide->image);
            }
            $image = $request->file('image');
            $file_extention = $request->file('image')->extension();
            $file_name = Carbon::now()->timestamp.'.'.$file_extention;
            $this->generatedSlideThumbnailsImage($image, $file_name);
            $slide->image = $file_name;
        }
        
        $slide->save();
        return redirect()->route('admin-slides')->with('status','Slide has been updated successfully!');
    }

    public function slide_delete($id)
    {
        $slide = Slide::find($id);
        if(File::exists(public_path('uploads/slides').'/'.$slide->image))
        {
            File::delete(public_path('uploads/slides').'/'.$slide->image);
        }
        $slide->delete();
        return redirect()->route('admin-slides')->with('status','Slide deleted successfully!');
    }

    public function contacts()
    {
        $contacts = Contact::orderBy('created_at', 'DESC')->paginate(10);
        return view('admin.contacts', compact('contacts'));
    }

    public function contacts_delete($id)
    {
        $contact = Contact::find($id);
        $contact->delete();
        return redirect()->route('admin.contacts')->with('status','Contact deleted successfully!');
    }

    public function search(Request $request)
    {
        $query = $request->input('query');
        $results = Product::where('name', 'LIKE', "%{$query}%")->get()->take(8);
        return response()->json($results);
    }
}