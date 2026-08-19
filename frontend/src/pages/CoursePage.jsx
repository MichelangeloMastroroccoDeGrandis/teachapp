import { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";
import { getJSON } from "../api.js";

// Single course. Mirrors app/views/courses/show.html.erb. Reads
// /courses/:id.json. Published courses are readable without logging in; the
// progress bar only appears when a signed-in student is enrolled.
export default function CoursePage() {
  const { id } = useParams(); // the :id from the /courses/:id route
  const [course, setCourse] = useState(null);
  const [status, setStatus] = useState("loading");

  useEffect(() => {
    setStatus("loading");
    getJSON(`/courses/${id}.json`)
      .then((data) => {
        setCourse(data);
        setStatus("ok");
      })
      .catch(() => setStatus("error"));
  }, [id]); // re-fetch if the id in the URL changes

  if (status === "loading") return <p className="text-gray-600">Loading course…</p>;
  if (status === "error")
    return <p className="text-gray-600">Could not load this course. It may be unpublished, or the backend is down.</p>;

  return (
    <>
      <Link to="/" className="text-sm text-indigo-600 hover:underline">
        ← All courses
      </Link>

      <h1 className="mt-2 text-2xl font-bold text-gray-900">{course.title}</h1>
      <p className="mt-2 text-gray-600">{course.description}</p>
      <p className="mt-1 text-sm text-gray-500">
        By {course.instructor} · ${course.price}
      </p>

      {course.enrolled && (
        <div className="mt-4">
          <div className="w-full bg-gray-200 rounded-full h-3">
            <div
              className="bg-indigo-600 h-3 rounded-full"
              style={{ width: `${course.progress_percent}%` }}
            />
          </div>
          <p className="mt-1 text-sm text-gray-500">{course.progress_percent}% complete</p>
        </div>
      )}

      <h2 className="mt-6 mb-2 text-lg font-semibold text-gray-900">Lessons</h2>
      <ol className="divide-y divide-gray-200 border border-gray-200 rounded-lg bg-white">
        {course.lessons.length === 0 && (
          <li className="px-4 py-3 text-gray-500">No lessons yet.</li>
        )}
        {course.lessons.map((lesson) => (
          <li key={lesson.id} className="px-4 py-3 text-gray-800">
            {lesson.position}. {lesson.title}
          </li>
        ))}
      </ol>
    </>
  );
}
