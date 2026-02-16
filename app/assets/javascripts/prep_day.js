// Prep day page - recipe column toggle functionality
document.addEventListener("DOMContentLoaded", function() {
  const checkboxes = document.querySelectorAll(".recipe-toggle-checkbox");

  // Only run if checkboxes exist on this page
  if (checkboxes.length === 0) return;

  checkboxes.forEach(checkbox => {
    checkbox.addEventListener("change", function() {
      const recipeId = this.value;
      const recipeColumn = document.getElementById(`recipe-column-${recipeId}`);

      if (recipeColumn) {
        if (this.checked) {
          recipeColumn.classList.remove("hidden");
        } else {
          recipeColumn.classList.add("hidden");
        }
      }
    });
  });
});
