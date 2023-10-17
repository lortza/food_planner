function shoppingListItemToggler() {
  document.addEventListener('DOMContentLoaded', function () {
    // let activeSection = document.getElementById('active-items')
    // let inactiveSection = document.getElementById('inactive-items')
    let searchResults = document.getElementById('searched-items')
    // let statusTagHTML = '<span class="status-tag js-remove-from-cart"><span class="material-icons-outlined in-cart" title="Item is purchased and scheduled for home delivery">shopping_cart</span></span>'

    if (activeSection || inactiveSection) {
      activeSection.addEventListener('click', function(e){
        let item = e.target;
        // let itemArticle = item.closest('article');

        // if (item.classList.contains('js-toggle')) {
        //   let statusTag = itemArticle.querySelector('.status-tag')
        //   if (statusTag){
        //     statusTag.remove();
        //   }

        //   itemArticle.remove();
        //   itemArticle.classList.add('item-crossed-off');
        //   inactiveSection.insertAdjacentHTML('afterbegin', itemArticle.outerHTML);
        // }

        // if (item.classList.contains('js-add-to-cart')) {
        //   let itemDisplayname = itemArticle.querySelector('.js-toggle')

        //   itemDisplayname.insertAdjacentHTML('afterend', statusTagHTML)
        //   item.remove();
        // }

        if ( item.classList.contains('aisle') ) {
          item.remove();
        }
      }) // end activeSection
    }// if on grocery list page

    // if (searchResults) {
    //   searchResults.addEventListener('click', function(e){
    //     let item = e.target;
    //     let itemHtml = item.parentNode;

    //     if ( item.classList.contains('js-toggle') ) {
    //       itemHtml.insertAdjacentHTML('afterbegin', '<i class="text-success">&#10003;</i>')
    //       itemHtml.insertAdjacentHTML('beforeend', '<span class="text-success item-added-confirmation">Added to list!</span>')
    //     }
    //   })
    // } // if searchResults
  })//close DOMContentLoaded
};
