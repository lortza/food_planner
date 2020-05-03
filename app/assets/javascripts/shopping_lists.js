function shoppingListItemToggler() {
  document.addEventListener('DOMContentLoaded', function () {
    let activeSection = document.getElementById('active-items')
    let inactiveSection = document.getElementById('inactive-items')
    let searchResults = document.getElementById('searched-items')
    let statusTagHTML = '<span class="status-tag js-remove-from-cart"><span class="material-icons-outlined in-cart">shopping_cart</span> In Cart</span>'

    if (activeSection || inactiveSection) {
      activeSection.addEventListener('click', function(e){
        let item = e.target;
        let itemArticle = item.parentNode.parentNode;

        if ( item.classList.contains('js-toggle') ) {
          let statusTag = itemArticle.querySelector('.status-tag')
          if (statusTag){
            statusTag.remove();
          }

          itemArticle.remove();
          itemArticle.classList.add('item-crossed-off');
          inactiveSection.insertAdjacentHTML('afterbegin', itemArticle.outerHTML);
        }

        if ( item.classList.contains('js-add-to-cart') ) {
          let itemArticle = item.parentNode.parentNode.parentNode;
          let itemDisplayname = itemArticle.querySelector('.js-toggle')

          itemDisplayname.insertAdjacentHTML('afterend', statusTagHTML)
          item.remove();
        }

        if ( item.classList.contains('aisle') ) {
          item.remove();
        }
      }) // end activeSection

      inactiveSection.addEventListener('click', function(e){
        let item = e.target;

        if ( item.classList.contains('js-toggle') ) {
          let itemArticle = item.parentNode.parentNode;

          itemArticle.remove();
          itemArticle.classList.remove('item-crossed-off');
          activeSection.insertAdjacentHTML('beforeend', itemArticle.outerHTML)
        }

        if ( item.classList.contains('js-add-to-cart') ) {
          let itemArticle = item.parentNode.parentNode.parentNode;
          let itemDisplayname = itemArticle.querySelector('.js-toggle')

          item.remove();
          itemArticle.remove();
          itemArticle.classList.remove('item-crossed-off');

          itemDisplayname.insertAdjacentHTML('afterend', statusTagHTML)
          activeSection.insertAdjacentHTML('beforeend', itemArticle.outerHTML)
        }
      }) // end inactiveSection
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

    function activateItem(itemArticle){
      itemArticle.remove();
      itemArticle.classList.remove('item-crossed-off');
      activeSection.insertAdjacentHTML('beforeend', itemArticle.outerHTML)
    }
  })//close DOMContentLoaded
};
