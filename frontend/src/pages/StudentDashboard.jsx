import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { getJSON } from "../api.js";

// Student dashboard ("My Learning"). Mirrors app/views/dashboards/student/show.html.erb.
// Reads /dashboards/student.json, which requires a signed-in student.
export default function StudentDashboard() {
  const [enrollments, setEnrollments] = useState([]);
  // "loading" | "ok" | "unauthorized" | "error"
  const [status, setStatus] = useState("loading");

  useEffect(() => {
    getJSON("/dashboards/student.json")
      .then((d) => {
        setEnrollments(d.enrollments);
        setStatus("ok");
      })
      .catch((err) => setStatus(err.code === "unauthorized" ? "unauthorized" : "error"));
  }, []);

  if (status === "loading") return <p className="text-gray-600">Loading your learning…</p>;
  if (status === "unauthorized")
    return (
      <p className="text-gray-600">
        You need to{" "}
        <a href="/users/sign_in" className="text-indigo-600 hover:underline">
          sign in as a student
        </a>{" "}
        to view your learning.
      </p>
    );
  if (status === "error") return <p className="text-gray-600">Could not load your dashboard.</p>;

  return (
    <>
      <h1 className="text-2xl font-bold text-gray-900">My Learning</h1>

      {enrollments.length === 0 && (
        <p className="mt-4 text-gray-600">You are not enrolled in any courses yet.</p>
      )}

      {enrollments.map((e) => (
        <div key={e.course_id} className="mt-4 rounded-xl border border-gray-200 bg-white p-5">
          <h2 className="text-lg font-semibold">
            <Link to={`/courses/${e.course_id}`} className="hover:text-indigo-600">
              {e.course_title}
            </Link>
          </h2>
          <div className="mt-3 w-full bg-gray-200 rounded-full h-3">
            <div
              className="bg-indigo-600 h-3 rounded-full"
              style={{ width: `${e.progress_percent}%` }}
            />
          </div>
          <p className="mt-1 text-sm text-gray-500">{e.progress_percent}% complete</p>
        </div>
      ))}
    </>
  );
}
