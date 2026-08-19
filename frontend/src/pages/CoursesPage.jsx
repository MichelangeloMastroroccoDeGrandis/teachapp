import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { getJSON } from "../api.js";

// Course list. Mirrors app/views/courses/index.html.erb. Reads the public
// /courses.json endpoint (no login needed).
export default function CoursesPage() {
  const [courses, setCourses] = useState([]);
  const [status, setStatus] = useState("loading"); // "loading" | "ok" | "error"

  useEffect(() => {
    getJSON("/courses.json")
      .then((data) => {
        setCourses(data);
        setStatus("ok");
      })
      .catch(() => setStatus("error"));
  }, []);

  if (status === "loading") return <p className="text-gray-600">Loading courses…</p>;
  if (status === "error")
    return <p className="text-gray-600">Could not load courses. Is the Rails backend running on port 3000?</p>;

  return (
    <>
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Courses vefvefv</h1>
      </div>

      {courses.length === 0 && <p className="text-gray-600">No published courses yet.</p>}

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
        {courses.map((course) => (
          <div
            key={course.id}
            className="rounded-xl border border-gray-200 bg-white p-5 hover:shadow-md transition-shadow"
          >
            <h2 className="text-lg font-semibold text-gray-900">
              <Link to={`/courses/${course.id}`} className="hover:text-indigo-600">
                {course.title}
              </Link>
            </h2>
            <p className="mt-2 text-sm text-gray-600">{course.description}</p>
            <p className="mt-3 text-sm font-medium text-indigo-600">${course.price}</p>
          </div>
        ))}
      </div>
    </>
  );
}
