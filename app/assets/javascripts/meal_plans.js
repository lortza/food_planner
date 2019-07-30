function mealPlanListToggler() {
  document.addEventListener('DOMContentLoaded', function () {
    let ingredientsSection = document.getElementById('section__ingredient-breakdown')
    let collapserButton = document.getElementById('button__ingredients-toggle')

    ingredientsSection.addEventListener('click', function (event) {
      let element = event.target
      if(element.classList.contains('caret')){
        let list = element.parentElement.parentElement.querySelector('ul');
        if(element.classList.contains('fa-caret-down')){
          hideBullets(element, list);
        } else {
          showBullets(element, list);
        }
      }
    });

    collapserButton.addEventListener('click', function(event){
      event.preventDefault();
      button = event.target;
      allCarets = ingredientsSection.getElementsByClassName('caret');

      if(button.classList.contains('opened')){
        button.textContent = 'Expand All';
        button.classList.remove('opened');
        button.classList.add('closed');

        for (let caret of allCarets) {
          let bulletList = caret.parentElement.parentElement.querySelector('ul');
          hideBullets(caret, bulletList);
        }
      } else {
        button.textContent = 'Collapse All';
        button.classList.remove('closed');
        button.classList.add('opened');
        // show all the bullets
        for (let caret of allCarets) {
          let bulletList = caret.parentElement.parentElement.querySelector('ul');
          showBullets(caret, bulletList);
        }
      }
    });

    function hideBullets(element, list){
      element.classList.remove('fa-caret-down')
      element.classList.add('fa-caret-left')
      list.style.display = 'none';
    };

    function showBullets(element, list){
      element.classList.remove('fa-caret-left')
      element.classList.add('fa-caret-down')
      list.style.display = 'block';
    };
  });
};
