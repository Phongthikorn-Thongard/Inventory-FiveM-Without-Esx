
$(document).ready(function() {
   
    console.log("Ready")

    function keydownEventListener(event) {
        if (event.keyCode === 27) {
            fetch(`https://${GetParentResourceName()}/close`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json; charset=UTF-8',
                },
                body: JSON.stringify({
                    foo: "basea",
                })
            }).then(resp => resp.json());
        }
    }

    window.addEventListener('message', function(event) {
        const data = event.data;

        if (!data.pause) {
            if (data.type === "show") {

                $(".container").fadeIn(10);
                document.addEventListener('keydown', keydownEventListener);

            } else if (data.type === "hide") {

                $(".container").fadeOut(10);
                document.removeEventListener('keydown', keydownEventListener);

            }
        }
    });
});
    //     const container = document.querySelector('#container');
    // const containerWidth = container.offsetWidth;
    // const containerHeight = container.offsetHeight;
    
    // container.addEventListener('mousemove', (e) => {
        //   const mouseX = e.clientX;
        //   const mouseY = e.clientY;
        //   const offsetX = 0.5 - mouseX / containerWidth;
        //   const offsetY = 0.5 - mouseY / containerHeight;
        //   const translateX = offsetX * containerWidth * 0.1;
        //   const translateY = offsetY * containerHeight * 0.1;
        //   container.style.transform = `translate(${translateX}px, ${translateY}px)`;
        // });