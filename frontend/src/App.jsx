import { Routes, Route } from "react-router-dom";
import Header from "./components/Header.jsx";
import Banner from "./components/Banner.jsx";
import Footer from "./components/Footer.jsx";
import CoursesPage from "./pages/CoursesPage.jsx";
import CoursePage from "./pages/CoursePage.jsx";
import InstructorDashboard from "./pages/InstructorDashboard.jsx";
import StudentDashboard from "./pages/StudentDashboard.jsx";

// Top-level layout. The shared Header, Banner and Footer wrap whichever page
// the current URL maps to (see the <Routes> below). This mirrors how the Rails
// layout renders the navbar/banner/footer partials around each view.
export default function App() {
  return (
    <div className="min-h-screen flex flex-col bg-gray-50 text-gray-900">
      <Header />
      <Banner />
      <main className="flex-1 w-full max-w-5xl mx-auto px-6 py-8">
        <Routes>
          <Route path="/" element={<CoursesPage />} />
          <Route path="/courses/:id" element={<CoursePage />} />
          <Route path="/dashboard/instructor" element={<InstructorDashboard />} />
          <Route path="/dashboard/student" element={<StudentDashboard />} />
        </Routes>
      </main>
      <Footer />
    </div>
  );
}
