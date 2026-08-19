import { useLocation } from "react-router-dom";

// Shared banner. Mirrors app/views/shared/_banner.html.erb, which shows the
// current page's title. Rails derives that title from the controller name; here
// we derive it from the first segment of the URL path.
const TITLES = {
  "": "Courses",
  courses: "Courses",
  dashboard: "Dashboard",
};

export default function Banner() {
  const { pathname } = useLocation();
  const segment = pathname.split("/")[1] || "";
  const title = TITLES[segment] ?? "TeachApp";

  return (
    <div className="bg-gray-200 px-6 py-6">
      <div className="max-w-5xl mx-auto">
        <h1 className="text-2xl text-center font-bold text-gray-500">{title}</h1>
      </div>
    </div>
  );
}
