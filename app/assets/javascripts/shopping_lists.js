function shoppingListItemToggler() {
  document.addEventListener('DOMContentLoaded', function () {
    let activeSection = document.getElementById('active-items')
    let inactiveSection = document.getElementById('inactive-items')

    activeSection.addEventListener('click', function(e){
      let item = e.target;
      let itemHtml = item.parentNode.parentNode;

      if ( item.classList.contains('js-toggle') ) {
        itemHtml.remove();
        itemHtml.classList.add('item-crossed-off');
        inactiveSection.insertAdjacentHTML('afterbegin', itemHtml.outerHTML);
      }

      if ( item.classList.contains('aisle') ) {
        item.remove();
      }
    })

    inactiveSection.addEventListener('click', function(e){
      let item = e.target;
      let itemHtml = item.parentNode.parentNode;

      if ( item.classList.contains('js-toggle') ) {
        itemHtml.remove();
        itemHtml.classList.remove('item-crossed-off');
        activeSection.insertAdjacentHTML('beforeend', itemHtml.outerHTML)
      }
    })
  })//close DOMContentLoaded
};
