function shoppingListItemToggler() {
  document.addEventListener('DOMContentLoaded', function () {
    let activeSection = document.getElementById('active-items')
    let inactiveSection = document.getElementById('inactive-items')

    activeSection.addEventListener('click', function(e){
      let item = e.target;
      let itemHtml = item.parentNode.parentNode;

      if ( item.classList.contains('js-toggle') ) {
        itemHtml.remove();

        console.log(itemHtml)
        let crossedOffItem = itemHtml.classList.add('item-crossed-off').outerHTML
        console.log(crossedOffItem)
        inactiveSection.insertAdjacentHTML('afterbegin', itemHtml.outerHTML)
      }
    })

    // inactiveSection.addEventListener('click', function(e){
    //   let item = e.target;
    //   let itemHtml = item.parentNode.parentNode;
    //
    //   if ( item.classList.contains('js-toggle') ) {
    //     itemHtml.remove();
    //
    //     let reactivatedItem = itemHtml.classList.remove('item-crossed-off').outerHTML
    //     inactiveSection.insertAdjacentHTML('afterbegin', reactivatedItem)
    //   }
    // })

  });
};
