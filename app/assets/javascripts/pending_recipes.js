// New Pending Recipe spinner loading state
document.addEventListener("DOMContentLoaded", function() {
  const loadingStatePartial = document.getElementById("js-loading-state-content-area");
  const pendingRecipeForm = document.getElementById("js-pending-recipe-form");

  // Only run if the elements exist on this page
  if (!pendingRecipeForm || !loadingStatePartial) return;

  // Show loading state when the form is submitted
  pendingRecipeForm.addEventListener("submit", function() {
    loadingStatePartial.classList.remove('hidden');
    pendingRecipeForm.classList.add('hidden');
  });
});