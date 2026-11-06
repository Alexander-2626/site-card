type Theme = "light" | "dark";

const root = document.documentElement;
const toggle = document.getElementById("theme-toggle") as HTMLButtonElement | null;

function applyTheme(theme: Theme): void {
  root.dataset.theme = theme;
  localStorage.setItem("theme", theme);
}

const saved = localStorage.getItem("theme") as Theme | null;
if (saved === "light" || saved === "dark") {
  applyTheme(saved);
}

toggle?.addEventListener("click", () => {
  const next: Theme = root.dataset.theme === "dark" ? "light" : "dark";
  applyTheme(next);
});

export {};