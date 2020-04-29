function shoppingListItemToggler() {
  document.addEventListener('DOMContentLoaded', function () {
    let activeSection = document.getElementById('active-items')
    let inactiveSection = document.getElementById('inactive-items')
    let searchResults = document.getElementById('searched-items')

    if (activeSection || inactiveSection) {
      activeSection.addEventListener('click', function(e){
        let item = e.target;
        let itemHtml = item.parentNode.parentNode;

        if ( item.classList.contains('js-toggle') ) {
          let statusTag = item.querySelector('.status-tag')
          if (statusTag){
            statusTag.remove();
          }

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
    }// if on grocery list page

    if (searchResults) {
      searchResults.addEventListener('click', function(e){
        let item = e.target;
        let itemHtml = item.parentNode;

        if ( item.classList.contains('js-toggle') ) {
          itemHtml.insertAdjacentHTML('afterbegin', '<i class="fas fa-check text-success"></i>')
          itemHtml.insertAdjacentHTML('beforeend', '<span class="text-success item-added-confirmation">Added to list!</span>')
        }
      })
    } // if searchResults

  })//close DOMContentLoaded
};
