<?php
namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::with('category')->latest()->paginate(10);
        return view('admin.products.index', compact('products'));
    }

    public function create()
    {
        $categories = Category::all();
        return view('admin.products.create', compact('categories'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'name'        => 'required|unique:products,name',
            'category_id' => 'required|exists:categories,id',
            'price'       => 'required|numeric',
            'stock'       => 'required|integer',
        ]);

        $slug = Str::slug($request->name);
        
        // Cek apakah slug sudah ada (untuk kasus nama mirip tapi beda karakter)
        if (Product::where('slug', $slug)->exists()) {
            return back()->withErrors(['name' => 'Nama produk ini menghasilkan URL yang sudah terpakai. Gunakan nama lain.'])->withInput();
        }

        $data = $request->all();
        $data['slug'] = $slug;

        if ($request->hasFile('image')) {
            $data['image'] = $request->file('image')->store('products', 'public');
        }

        Product::create($data);
        return redirect()->route('admin.products.index')->with('success', 'Produk berhasil ditambah');
    }

    public function edit(Product $product)
    {
        $categories = Category::all();
        return view('admin.products.edit', compact('product', 'categories'));
    }

    public function update(Request $request, Product $product)
    {
        $request->validate([
            'name'        => 'required|unique:products,name,' . $product->id,
            'category_id' => 'required|exists:categories,id',
            'price'       => 'required|numeric',
            'stock'       => 'required|integer',
        ]);

        $slug = Str::slug($request->name);

        // Cek apakah slug sudah ada di produk LAIN
        if (Product::where('slug', $slug)->where('id', '!=', $product->id)->exists()) {
            return back()->withErrors(['name' => 'Nama produk ini menghasilkan URL yang sudah terpakai. Gunakan nama lain.'])->withInput();
        }

        $data = $request->all();
        $data['slug'] = $slug;

        if ($request->hasFile('image')) {
            $data['image'] = $request->file('image')->store('products', 'public');
        }

        $product->update($data);
        return redirect()->route('admin.products.index')->with('success', 'Produk berhasil diupdate');
    }

    public function destroy(Product $product)
    {
        $product->delete();
        return redirect()->route('admin.products.index')->with('success', 'Produk berhasil dihapus');
    }
}