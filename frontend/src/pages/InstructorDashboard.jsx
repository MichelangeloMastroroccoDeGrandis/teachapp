import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { getJSON } from "../api.js";

// Instructor dashboard. Mirrors app/views/dashboards/instructor/show.html.erb.
// Reads /dashboards/instructor.json, which requires a signed-in instructor.
export default function InstructorDashboard() {
  const [data, setData] = useState(null);
  // "loading" | "ok" | "unauthorized" | "error"
  const [status, setStatus] = useState("loading");

  useEffect(() => {
    getJSON("/dashboards/instructor.json")
      .then((d) => {
        setData(d);
        setStatus("ok");
      })
      .catch((err) => setStatus(err.code === "unauthorized" ? "unauthorized" : "error"));
  }, []);

  if (status === "loading") return <p className="text-gray-600">Loading dashboard…</p>;
  if (status === "unauthorized")
    return (
      <p className="text-gray-600">
        You need to{" "}
        <a href="/users/sign_in" className="text-indigo-600 hover:underline">
          sign in as an instructor
        </a>{" "}
        to view this dashboard.
      </p>
    );
  if (status === "error") return <p className="text-gray-600">Could not load the dashboard.</p>;

  return (
    <>
      <h1 className="text-2xl font-bold text-gray-900">Instructor Dashboard</h1>
      <p className="mt-1 text-gray-600">
        Total students across all courses: {data.total_students}
      </p>

      <table className="mt-6 w-full text-sm border border-gray-200 rounded-lg overflow-hidden bg-white">
        <tbody>
          {data.courses.map((course) => (
            <tr key={course.id} className="border-b border-gray-100 last:border-0">
              <td className="px-4 py-3">
                <Link to={`/courses/${course.id}`} className="text-indigo-600 hover:underline">
                  {course.title}
                </Link>
              </td>
              <td className="px-4 py-3 text-gray-500">{course.students_count} students</td>
              <td className="px-4 py-3">
                <span
                  className={`rounded-full px-2 py-0.5 text-xs font-medium ${
                    course.published ? "bg-green-100 text-green-700" : "bg-gray-100 text-gray-600"
                  }`}
                >
                  {course.published ? "Published" : "Draft"}
                </span>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </>
  );
}
