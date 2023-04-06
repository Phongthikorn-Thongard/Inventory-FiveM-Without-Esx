$(document).ready(function () {
  
  $(".container").fadeOut(10);

  for (let i = 1; i <= Config.QuickSlot; i++) {
    const slot = document.createElement('button');
    slot.type = 'button';
    slot.classList.add('slot');
    slot.id = `slot${i}`;
    
    const slotNumber = document.createElement('div');
    slotNumber.classList.add('slotnumber');
    slotNumber.textContent = i;
    
    const slotImage = document.createElement('img');
    slotImage.src = '././image/emptyitem.png';
    slotImage.classList.add('slot-image');
    
    slot.appendChild(slotNumber);
    slot.appendChild(slotImage);
    
    $(".quickslot").append(slot);
  }
  
  for (let i = 1; i <= Config.BackpackSlot; i++) {
    const slot = document.createElement('button');
    slot.type = 'button';
    slot.classList.add('slot');
    
    
    // const slotNumber = document.createElement('div');
    // slotNumber.classList.add('slotnumber');
    // slotNumber.textContent = i;
    
    // const slotImage = document.createElement('img');
    // slotImage.src = '././image/emptyitem.png';
    // slotImage.classList.add('slot-image');
    
    // slot.appendChild(slotNumber);
    // slot.appendChild(slotImage);
    
    $(".item_backpack .slot_container").append(slot);
  }
  for (let i = 1; i <= Config.SecretSlot; i++) {
    const slot = document.createElement('button');
    slot.type = 'button';
    slot.classList.add('slot');
    
    
    
    $(".secret_backpack .slot_container").append(slot);
  }
  
  const Slots = document.querySelectorAll('.slot');
  const iteminteractbutton = document.querySelectorAll('.interactbtn');
  const ItemInteractMenu = document.querySelector('#item_interact');
  
  console.log("Ready to add event")
  Slots.forEach(slot => {
    slot.addEventListener('contextmenu', (e) => {
      e.preventDefault(); // add this line
      ItemInteractMenu.style.display = "flex";
      ItemInteractMenu.style.left = `${e.pageX}px`;
      ItemInteractMenu.style.top = `${e.pageY}px`;
    });
  });
  
  window.addEventListener('click', () => {
    ItemInteractMenu.style.display = "none";
  });
  
  iteminteractbutton.forEach(btn => {
    btn.addEventListener('contextmenu', (e) => {
      e.preventDefault();
      ItemInteractMenu.style.display = "none";
    });
  });
});