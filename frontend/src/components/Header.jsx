import { Link } from "react-router-dom";

// Shared top navigation. Mirrors app/views/shared/_navbar.html.erb.
//
// Difference from Rails: the Rails navbar shows different links depending on
// whether someone is signed in (it can call `user_signed_in?` on the server).
// A React SPA doesn't know that without asking the server, so this version keeps
// it simple: it always shows both dashboard links plus a "Sign in" link.
//
// "Sign in" is a plain <a>, not a React <Link>, because it points at the Rails
// Devise page (served through the Vite proxy). Signing in there sets the session
// cookie that the dashboards rely on.
//
// It opens in a NEW TAB (target="_blank") so this React tab stays put instead of
// being navigated away to Rails. rel="noopener noreferrer" is the safety pairing
// for any target="_blank" link: it stops the opened page from reaching back into
// this one via window.opener (a "reverse tabnabbing" trick).
export default function Header() {
  return (
    <nav className="bg-white border-b border-gray-200 px-6 py-3 flex items-center justify-between">
      <Link to="/" className="text-xl font-bold text-slate-600">
        TeachApp
      </Link>

      <div className="flex items-center gap-4 text-sm font-medium">
        <Link to="/dashboard/instructor" className="text-gray-700 hover:text-indigo-600">
          Instructor
        </Link>
        <Link to="/dashboard/student" className="text-gray-700 hover:text-indigo-600">
          My Learning
        </Link>
        <a
          href="/users/sign_in"
          target="_blank"
          rel="noopener noreferrer"
          className="text-slate-600 hover:text-slate-800"
        >
          Sign in
        </a>
      </div>
    </nav>
  );
}
