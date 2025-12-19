// Recipe show page - instruction crossing functionality
document.addEventListener("DOMContentLoaded", function() {
  const instructionItems = document.querySelectorAll("#js-instructions .tab-content ol li");

  // Only run if instruction items exist on this page
  if (instructionItems.length === 0) return;

  instructionItems.forEach(line => {
    line.classList.add('cursor-pointer');
    line.addEventListener('click', function() {
      this.classList.toggle('line-through');
    });
  });
});
