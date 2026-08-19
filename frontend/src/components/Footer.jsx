// Shared footer. Mirrors app/views/shared/_footer.html.erb.
export default function Footer() {
  const year = new Date().getFullYear();

  return (
    <footer className="bg-white border-t border-gray-200 px-6 py-4 mt-12">
      <div className="max-w-5xl mx-auto flex items-center justify-between text-sm text-gray-500">
        <span>&copy; {year} TeachApp</span>
        <div className="flex gap-4">
          <a href="#" className="hover:text-slate-600">About</a>
          <a href="#" className="hover:text-slate-600">Contact</a>
        </div>
      </div>
    </footer>
  );
}
