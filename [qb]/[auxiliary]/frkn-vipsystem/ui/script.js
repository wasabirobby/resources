var cases = null;
var curcase = null;
var vidid = null;
var vidwintime = 3500;
$(window).ready(function() {
    window.addEventListener('message', (event) => {
        let data = event.data;
        
		if (data.action == "load"){ 

            $("body").css("display","unset");

          if(data.config.EnableAnimAndTheme == true) {
            $("theme1").css("display", "none");
            $("theme2").css("display", "block");
            containerinit(data);
          }else {
            init(data);
            
            $(".cases").css("display","block");
            $("theme1").css("display", "block");
            $("theme2").css("display", "none");
          }
		  
		}
    }); 
});

$(document).on("mouseenter", ".kasa", function(e){
    $("#ics").html("ITEMS YOU CAN WIN<br>");
    curcase = parseInt($(this).data("id"));
    if(cases) {
        for (let i = 0; i < cases.length; i++) {
            if(cases[i].no == parseInt($(this).data("id"))) {

                

               if(cases[i].guaranteed_prize) {
                $(".garanti").fadeIn();
                $(".gp").html("GUARANTED <br>PRIZE");
                $(".garanti img").attr("src", "items/" + cases[i].guaranteed_prize.item + ".png");
               }else {
                $(".gp").html("NO GUARANTED <br>PRIZE");
                $(".garanti").fadeOut();
               }

               $.each(cases[i].items, function (key, val) {  
                var renk = "#40afff";
                if(val.rarity) {
                  switch(val.rarity) {
                    case 1:
                        renk = "#808489"
                    break;
                    case 2:
                        renk = "#47940b"
                    break;
                    case 3:
                        renk = "#2a88cc"
                    break;
                    case 4:
                        renk = "#a047c7"
                    break;
                    case 5:
                        renk = "#bd722c"
                    break;
                  }
                }
                $("#ics").append(`
                <div class="incaseitems">
                <img src="items/${val.item}.png" style="left: 0;top: 0;" />
                <mavi style="  background: ${renk};
                box-shadow: 0px 0px 7px 3px  ${renk};"  ></mavi>
                </div>                
                `);
               });
               $("#ccs").html(`<i class="fab fa-bitcoin"></i> ${cases[i].credit}`);
               $("#case_name").html(cases[i].name);
               $("#case_img").attr("src", cases[i].image);
               break;   
            }
        }
    }
});

$(document).on("click", ".kasa", function(e){
    $(".kasainfo").fadeIn(); 
    var info = null;
    // if(cases) {
    //     for (let index = 0; index < cases.length; index++) {
    //         if(cases[index].no == parseInt($(this).data("id"))) {
    //            info = cases[index];
    //         }
    //     }
    // }
 
	
});

 
function closeinfo() { $(".kasainfo").fadeOut();  }; 
function openmore() {  $(".vidcont").html(""); }  


function playanim() {

    $.post("https://frkn-vipsystem/checkPrice", JSON.stringify({ id: curcase }), function(x){
    

    updateCoin();
    

    p = SFOR(GeCurrentCaser(curcase).items);
 
    $(".vidcont").html(`
    ${vidid}
    <div class="shw">
    <cont>
    <div class="ustortacizgi"></div><div class="ustortacizgi"></div>
    <div class="ustortacizgi"></div><div class="ustortacizgi"></div>
    <div class="ustortacizgi"></div><div class="ustortacizgi"></div>
    <div class="ustortacizgi"></div><div class="ustortacizgi"></div>
    </cont>
    <h1>${p.label}</h1>
    <p>Count: ${p.count}</p>
    <img src="items/${p.item}.png" />
    <a href="javascript:openmore();" >OPEN MORE</a>
    </div>
	`);



    $.post("https://frkn-vipsystem/prize", JSON.stringify({ prize: p }));
    
  

	setTimeout(function(){ $('video').trigger('play'); }, 100);
	$('.shw').fadeIn(vidwintime);
	

    

    });
 
}


GeCurrentCaser = (x) => {
    if(cases) {
        for (let i = 0; i < cases.length; i++) { 
            if(cases[i].no == parseInt(x)) {
                return cases[i];
            }
        }
    }
}

SFOR = (ch) => {
    var index = Math.floor(Math.random() * ch.length);
    return ch[index];
}



function containerinit(data) {
    updateCoin();
    Config = data.config;
    cases = Config.Cases;

    $("#tsor").html(`${Config.TebexStoreName} SERVER STORE`);
    $("#tsor").attr("src", Config.TebexStoreUrl);
	
	vidid = Config.Anims[Config.Anim-1].embed;
	vidwintime = Config.Anims[Config.Anim-1].prizeTime;
 
	
	 
    $("#boxs").html("");
    $.each(cases, function (key, val) {   

        e = `
        <div class="kasa" data-id="${val.no}" >
          <h2>${val.name} <br> CONTAINER</h2>
          <img src="${val.image}">
          <span><i class="fab fa-bitcoin"></i> <b>${val.credit}</b></span>
         </div>
        `;
        $("#boxs").append(e);
    });
}






function init(data) {
   updateCoin();
   cases = data.config.Cases;
   $(".kutular").html("");
   $.each(cases, function (key, val) {   
      
	  e = `
	  
<div class="kutu">
<img src="${val.image}" style="${val.style}" />
<span>${val.name}</span>
<a href="javascript:loadcase('${val.no}');">${val.credit} <i class="fab fa-bitcoin"></i></a>
</div>
	  
	  `;
   
      $(".kutular").append(e);
	  
   });

   


}	


function loadcase(no) {
	$.post("https://frkn-vipsystem/getCase", JSON.stringify({ no: no }), function(x){
        $("#kredigereken").html(x.credit+` <i class="fab fa-bitcoin"></i>`);
		
		
		$(".cases").css("display","none");
		$(".container").css("display","grid");
		var caseitems = x.items;
		curcase = x;
   $("#spinnerList").html("");
    $.each(caseitems, function (key, val) {   
		$("#spinnerList").append(`<li class="spinner-items__item" data-item="${val.item}" data-type="${val.type}" data-count="${val.count}" id="${key}"><img src="../ui/items/${val.item}.png" style="width:110px" /></li>`);
   });
		
		
	});
}

var canspin = true;

class SpinnerAnimation {
    constructor({container, list}) {
      this.tickSound = new Audio("case.mp3");
      this.tickSound.playbackRate = 1;
      
      this.winSound = new Audio("win.mp3");
      
	  
	  
      this.firstRound = true;

      this.reset();

      this.spinnerContainer = document.getElementById(container);
      this.spinnerList = spinnerContainer.children.namedItem(list);
      this.spinnerMarker = spinnerContainer.children.namedItem("spinnerMarker");
      this.spinnerItems = this.spinnerList.children;
      this.spinnerWon = document.getElementById("spinnerWon");
    }
  
    reset() {
        this.started = false;
        this.stopped = false;
        this.stopAnimation = false;
        this.lowerSpeed = 0;
        this.ticks = 0;
        this.offSet = 0;
        this.recycle = false;
        this.tick = false;
        this.state = null;
        this.speed = 0;
        this.winningItem = 0;
        this.firstRound = false;
    }

    start(speed = 1200) {
        this.started = true;
        this.speed = speed;
        this.loop();
    }

    loop() {
        let dt = 0; // Delta Time is the amount of time between two frames
        let last = 0; // Last time of frame

        // The Animation Loop
        function loop(ms) {

            if(this.recycle) {
                this.recycle = false;
                const item = spinnerList.firstElementChild;
                spinnerList.append(item);
            }

            this.tickSound.play();

            if(this.tick) {
                this.tick = false;
                this.tickSound.play();
            }

            this.offSet += this.speed * dt;

            const ct = ms / 1000; // MS == The amount of Milliseconds the animation is already going for. Divided by 1000 is the amount of seconds
            dt = ct - last;
            last = ct;

            // Move the item to the left
            this.spinnerList.style.right = this.offSet + "px";
          
            if(this.offSet >= 122 ) {
                this.recycle = true;
                this.offSet = 0;
                this.tick = true;
                this.ticks += 1;
                if(this.ticks >= 20 && (Math.random() * 10) >= 5) {
                    this.stop();
                }
            }

            if(this.stopped) {
                let stopped = false;
                if(!stopped) this.speed -= this.lowerSpeed;

                if(this.speed <= 0) {
                    stopped = true;
                    this.speed = 0;
                }

                if(stopped) {
                    if(this.offSet >= 58.6) {
                        this.offSet += 6;
                    } else {
                        this.offSet -= 6;
                    }

                    if(this.offSet >= 122 || this.offSet <= 0) {
                        this.stopAnimation = true;
                        
                        this.winSound.play();
                      
                        if(this.offSet >= 122) {
                          this.winningItem = 5;
                          this.spinnerItems.item(5).classList.add("win");
                          // this.spinnerWon.innerText += this.spinnerItems.item(5).innerText;
						  kazanilan($(".win").data("item"), $(".win").data("type"), $(".win").data("count"));
                          this.offSet = 122;
                        }
                        
                        if(this.offSet <= 0) {
                          this.winningItem = 4;
                          this.spinnerItems.item(4).classList.add("win");
                          // this.spinnerWon.innerText += this.spinnerItems.item(4).innerText;
						  kazanilan($(".win").data("item"), $(".win").data("type"), $(".win").data("count"));
                          this.offSet = 0;
						  // console.log($(".win").data("item"));
						  
                        }
						canspin = true;
						updateCoin();
						// $("#startSpinner").css("display","unset");
                      
                    }
                  
                }
            }

            if(!this.stopAnimation) {
                requestAnimationFrame(loop);
            }
        }

        // Bind Class to loop function
        loop = loop.bind(this);
        requestAnimationFrame(loop);
    }

    stop() {
        this.stopped = true;

        // Calculate a random lower speed
        this.lowerSpeed = Math.ceil(Math.random() * 10) + 1;
    }
}

const startSpinnerBtn = document.getElementById("startSpinner");
const closebtn = document.getElementById("close");

const animation = new SpinnerAnimation({
    container: "spinnerContainer",
    list: "spinnerList"
});


closebtn.addEventListener("click", (e) => {
	
	if(canspin == true) {
    $(".cases").css("display","block");
    $(".container").css("display","none");
	$(".kutular").html("");
    $.each(cases, function (key, val) {   
      
	  e = `
	  
<div class="kutu">
<img src="${val.image}" style="${val.style}" />
<span>${val.name}</span>
<a href="javascript:loadcase('${val.no}');">${val.credit} <i class="fab fa-bitcoin"></i></a>
</div>
	  
	  `;
   
      $(".kutular").append(e);
   });
   }
});

startSpinnerBtn.addEventListener("click", (e) => {
    if(animation.started == "ready") { return; }
	if(canspin == true) {
    $.post("https://frkn-vipsystem/checkCoin", JSON.stringify({ credit: curcase.credit }), function(x){
 
    if(x==true) {
	openSound = new Audio("open.mp3");
    openSound.play();
	// $("#startSpinner").css("display","none");
    if(!animation.firstRound) animation.spinnerItems.item(animation.winningItem).classList.remove("win");
    animation.reset();
    animation.start();
	canspin = false;
	}
	});
	}	 
});


function kazanilan(x,y,z) {
	item = x;
	$(".kazanilan").css("display","block");
	$("#winitem").attr("src", "../ui/items/"+x+".png");
	// $.post("https://frkn-vipsystem/case", JSON.stringify({ name: item }), function(x){ });
    $.post("https://frkn-vipsystem/prize", JSON.stringify({ prize: { item: x, type: y, count: z } }));
}


function updateCoin() {
	
	$.post("https://frkn-vipsystem/getCoin", JSON.stringify({ }), function(x){ 
    
	   $(".coinhesap").html(`${x} <i class="fab fa-bitcoin"></i>`);
       $(".sagust").html(`<span><i class="fab fa-bitcoin"></i> <b>${x}</b></span>`);
       $("#main-page-count").html(`${x} VIP coins`);
       $("#carbuy-coin").html(`${x} VIP coins`);
       $("#item-coin").html(`${x} VIP coins`);

	});
}

function closex() {
	
   $(".kazanilan").css("display","none");
	
}

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: 
		    $("body").css("display","none");
            $(".cases").css("display","none");
			$(".kazanilan").css("display","none");
			$(".container").css("display","none");
			$.post("https://frkn-vipsystem/close", JSON.stringify({}), function(x){});
            break;
    }
});



// FRKN CODE

function carbuy(){
    $("#carbuy").fadeIn(500);
    $("#esc").fadeIn(500);
    $("#car-rentpage").fadeOut(500);
    $("#main-page").fadeOut(500);
    $("#header").fadeOut(500);
}

function esc(){
    $("#carbuy").fadeOut(500);
    $("#esc").fadeOut(500);
    $("#car-rentpage").fadeOut(500);
    $("#item-page").fadeOut(500);
    $("#container-case").fadeOut(500);
    $(".background-red").css("display","block");
    $("#money-page").fadeOut(500);
    $("#main-page").fadeIn(500);
    $("#header").fadeIn(500);
}

function carrent(){
    $("#car-rentpage").fadeIn(500);
    $("#esc").fadeIn(500);
    $("#main-page").fadeOut(500);
    $("#header").fadeOut(500);
}

function item(){
    $("#item-page").fadeIn(500);
    $("#esc").fadeIn(500);
    $("#main-page").fadeOut(500);
    $("#header").fadeOut(500);
}

function money(){
    $("#money-page").fadeIn(500);
    $("#esc").fadeIn(500);
    $("#main-page").fadeOut(500);
    $("#header").fadeOut(500);
}

function container(){
    $("#container-case").fadeIn(500);
    $("#esc").fadeIn(500);
    $("#main-page").fadeOut(500);
    $("#header").fadeOut(500);
    $(".background-red").css("display","none");
}

// ITEMS START
window.addEventListener('message', function(event) {
    if(event.data.action=="close"){
        $(".item-cont").html("");
    }
    $.each(event.data.Item, function (key, val) {  
        $(".item-cont").append(`
         <div onclick="itemselect('`+val.label+`','`+val.image+`','`+val.desc+`','`+val.category+`','`+val.coin+`','`+val.name+`')" class="craft-card">
        <div class="car-name">`+val.label+`</div>
        <img class="car-img" src="`+val.image+`" />
      </div>              
        `);
       });
})

function itemselect(label,image,desc,category,coin,name){
 $(".item-select").html('')
 $(".item-select").append(`
 <div class="cost">Cost</div>
 <div class="coin">`+coin+` vip coins</div>
 <div class="name">`+label+`</div>
 <div class="category">`+category+`</div>
 <div class="cost">Cost</div>
 <div class="desc-head">Desc</div>
 <div class="desc">`+desc+`</div>
 
 <div onclick="buytext()" class="buy">Buy</div>
 <div onclick="drivetest('`+name+`')" class="testdrive">Test Drive  </div>
 <div class="car-buy-cont">
 <div class="car-select-buy-text-header">Buying an item </div>
 <div class="car-select-buy-text">Do you really want to buy this item?Price `+coin+` vip coins</div>
 <div onclick="itembuy('`+coin+`','`+name+`')" class="car-select-buy-button">Buy </div>
 <div onclick="cancel()" class="car-select-cancel-button">Cancel</div>
 <hr class="car-select-cont-hr">
 <hr class="car-select-cont-hr2">
</div>  

 <img class="pant" src="`+image+`">
 <img class="cloth" src="./images/clothes.png"> 
 `)
}

function itembuy(coin,name){
    $.post("https://frkn-vipsystem/checkCoin", JSON.stringify({ credit: parseInt(coin) ,item:name,buytype:"item"}), function(x){
        if(x==true){
            $("body").css("display","none");
            $(".cases").css("display","none");
			$(".kazanilan").css("display","none");
			$(".container").css("display","none");
            $(".car-buy-cont").css("display","none");
            $(".item-cont").html("");
            $("#car-rentpage").animate({opacity: 1}, 1000);
            $(".page-carbuy").animate({opacity: 1}, 1000);
            $("#money-page").animate({opacity: 1}, 1000);
            $("#item-page").animate({opacity: 1}, 1000);
			$.post("https://frkn-vipsystem/close", JSON.stringify({}), function(x){});
        }
    });
}

// ITEMS FINISH



// RENT CAR START
window.addEventListener('message', function(event) {
    if(event.data.action=="close"){
        $(".car-slider-container").html("");
    }
    $.each(event.data.RentCar, function (key, val) {  
        $(".car-slider-container").append(`
        <div onclick="rentselect('`+val.label+`','`+val.image+`','`+val.coin+`','`+val.name+`')" 
        class="car-card">
      <div class="car-name">`+val.label+`</div>
      <img class="car-img" src="`+val.image+`" />
    </div>        
        `);
    });
})

function rentbuy(label,image,coin,name){
    $.post("https://frkn-vipsystem/checkCoin", JSON.stringify({ credit: parseInt(coin) ,carname:name,buytype:"rent"}), function(x){
        if(x==true){
            $("body").css("display","none");
            $(".cases").css("display","none");
			$(".kazanilan").css("display","none");
			$(".container").css("display","none");
            $("#car-rentpage").animate({opacity: 1}, 1000);
            $(".page-carbuy").animate({opacity: 1}, 1000);
            $("#money-page").animate({opacity: 1}, 1000);
            $("#item-page").animate({opacity: 1}, 1000);
			$.post("https://frkn-vipsystem/close", JSON.stringify({}), function(x){});
        }
    });
}

function rentselect(label,image,coin,name){
    $(".car-select").html('')
    $(".car-select").append(`
    <hr class="car-select-hr" />
    <div class="car-select-cost">Cost</div>
    <div class="car-select-name">`+label+`</div>
    <div class="car-select-car-price">`+coin+` Vip Coin</div>
    <img  class="car-select-image" src="`+image+`">
    <div class="car-rent-info">The car is given for 14 days</div>
    <div onclick="buytext()" class="car-select-buy">To buy</div>
    <div class="car-buy-cont">
    <div class="car-select-buy-text-header">Buying an car </div>
    <div class="car-select-buy-text">Do you really want to buy this car?Price `+coin+` vip coins</div>
    <div onclick="rentbuy('`+label+`','`+image+`','`+coin+`','`+name+`')" class="car-select-buy-button">Buy </div>
    <div onclick="cancel()" class="car-select-cancel-button">Cancel</div>
    <hr class="car-select-cont-hr">
    <hr class="car-select-cont-hr2">
  </div>


`)
}

window.addEventListener('message', function(event) {
    if(event.data.action=="close"){
        $(".money-cont").html("");
    }
    $.each(event.data.BuyingCash, function (key, val) {
        $(".money-cont").append(`
        <div onclick="moneyselect('`+val.label+`','`+val.money+`','`+val.coin+`')" class="car-card">
        <div class="car-name">`+val.label+`</div>    
        <hr>
        <img class="car-img" src="`+val.image+`" />
        </div> 
        `);
    })
})

function moneyselect(label,money,coin){
    $(".money-select").html('')
    $(".money-select").append(`
     <hr class="main-hr">
    <div class="cost">Cost</div>
    <div class="coin">`+coin+` vip coins</div>
    <div class="name">`+label+`</div>
    <div class="category">`+money+` virtuals</div>
    <div onclick="buytext()" class="buy">Buy</div>
    <div class="car-buy-cont">
    <div id="moneyheader" class="car-select-buy-text-header">Buying an money</div>
    <div id="moneytext" class="car-select-buy-text">Do you really want to buy this money?Price `+coin+` vip coins</div>
    <div id="moneybuybutton" onclick="moneybuy('`+coin+`','`+label+`','`+money+`')" class="car-select-buy-button">Buy </div>
    <div id="moneycancel" onclick="cancel()" class="car-select-cancel-button">Cancel</div>
    <hr  id="moneyhr1" class="car-select-cont-hr">
    <hr  id="moneyhr2" class="car-select-cont-hr2">
   </div>  



    `)
}

function moneybuy(coin,label,money){
    $.post("https://frkn-vipsystem/checkCoin", JSON.stringify({ credit: parseInt(coin) ,money:money,buytype:"cash"}), function(x){
        if(x==true){
            $("body").css("display","none");
            $(".cases").css("display","none");
			$(".kazanilan").css("display","none");
			$(".container").css("display","none");
            $(".car-buy-cont").css("display","none");
            $(".money-cont").html("");
            $("#car-rentpage").animate({opacity: 1}, 1000);
            $(".page-carbuy").animate({opacity: 1}, 1000);
            $("#money-page").animate({opacity: 1}, 1000);
            $("#item-page").animate({opacity: 1}, 1000);
			$.post("https://frkn-vipsystem/close", JSON.stringify({}), function(x){});
        }
    });
}


window.addEventListener('message', function(event) {
    if(event.data.action=="close"){
        $(".slider-cont").html("");
    }
    $.each(event.data.OwnedCar, function (key, val) {
        $(".slider-cont").append(`
        <div onclick="ownedcarselect('`+val.label+`','`+val.maximumspeed+`','`+val.trunkcapacity+`','`+val.acceleration100+`','`+val.fueltankcapacity+`','`+val.insurance+`','`+val.extras+`','`+val.image+`','`+val.coin+`','`+val.name+`')" class="cart">
        <div id="sha"  class="shadow"></div>
        <img src="`+val.image+`" alt="">
        <div  class="card-name">`+val.label+`</div>
    </div> 
        `);
    })
})

function ownedcarselect(label,maximumspeed,trunkcapacity,acceleration100,fueltankcapacity,insurance,extras,image,coin,name){
    $(".sayfa").html('')
    $(".sayfa").append(`
    <div class="headers"> Unique Cars </div>
    <hr>
    <div class="balanca-text">Balance</div>
    <div class="coin-count">400 VIP coins</div>
    <hr class="two-hr">

      <img class="main-image" src="`+image+`" alt="">
      <div class="car-name">`+label+`</div>
      <div class="cost-cont">
        <div class="text">COST</div>
        <div class="cost">`+coin+` vc</div>
    </div>
  
    <div class="max-header">Maximum Speed</div>
    <div class="max">`+maximumspeed+` km/h</div>
  
    <div class="trunk-header">Trunk Capacity</div>
    <div class="trunk">`+trunkcapacity+` l</div>
  
    <div class="ac-header">Acceleration to 100km/h</div>
    <div class="ac">`+acceleration100+` sec.</div>
  
    <div class="fuel-header">Fuel tank capacity</div>
    <div class="fuel">`+fueltankcapacity+` l</div>
  
    <div class="ins-header">insurance</div>
    <div class="ins">`+insurance+` days</div>
  
    <div class="extra-header">Extras</div>
    <div class="extra">`+extras+` </div>
  
    <div onclick="buytext()" class="buy">Buy</div>
    <div onclick="drivetest('`+name+`')" class="testdrive">Test Drive  </div>
    <div class="car-buy-cont">
    <div class="car-select-buy-text-header">Buying an car </div>
    <div class="car-select-buy-text">Do you really want to buy this car?Price `+coin+` vip coins</div>
    <div onclick="ownedcarbuy('`+coin+`','`+name+`')" class="car-select-buy-button">Buy </div>
    <div onclick="cancel()" class="car-select-cancel-button">Cancel</div>
    <hr class="car-select-cont-hr">
    <hr class="car-select-cont-hr2">
  </div>  

`)
}

function drivetest(name){
    $.post("https://frkn-vipsystem/test", JSON.stringify({name:name}), function(x){
    })
    $("body").css("display","none");
    $(".cases").css("display","none");
    $(".kazanilan").css("display","none");
    $(".container").css("display","none");
    $("#car-rentpage").animate({opacity: 1}, 1000);
    $(".page-carbuy").animate({opacity: 1}, 1000);
    $("#money-page").animate({opacity: 1}, 1000);
    $("#item-page").animate({opacity: 1}, 1000);
    $.post("https://frkn-vipsystem/close", JSON.stringify({}), function(x){});
}

function ownedcarbuy(coin,name){
    $.post("https://frkn-vipsystem/checkCoin", JSON.stringify({ credit: parseInt(coin) ,carname:name,buytype:"owned"}), function(x){
        if(x==true){
            $("body").css("display","none");
            $(".cases").css("display","none");
			$(".kazanilan").css("display","none");
			$(".container").css("display","none");
            $("#car-rentpage").animate({opacity: 1}, 1000);
            $(".page-carbuy").animate({opacity: 1}, 1000);
            $("#money-page").animate({opacity: 1}, 1000);
            $("#item-page").animate({opacity: 1}, 1000);
			$.post("https://frkn-vipsystem/close", JSON.stringify({}), function(x){});
        }
    });
}

window.addEventListener('message', function(event) {
    $.each(event.data.PromotionPack, function (key, val) {
    $(".cont-first-pack").append(`
    <div class="firstdisplay"> 
    <div class="light">Pack of the</div>
    <div class="bold">Beginner</div>
    <img class="imgfirst" src="./images/referal-money.png">
    <!--     <img class="imgtwo" src="`+val.image+`">    -->
    <i class='fa fa-clock'></i>
    <div class="text-light">The promotion</div>
    <div class="text-bold">is over</div>
    <div class="prime">`+val.label+` </div>
    <div class="price">$`+val.price+`</div>
    <div onclick="questionopen()" class="clothing">Buy</div>
    </div>
    <div class="question-cont">
    <div class="question-text">Are you sure?</div>
    <div class="question-mini">Are you sure you want to buy `+val.label+` model car and `+val.price+` cash by giving `+val.coin+` coins?</div>
    <div onclick="packbuy('`+val.price+`','`+val.name+`','`+val.coin+`')" class="question-button">Buy</div>
    <div onclick="firstcancel()" class="question-cancel">Cancel</div>
  </div>
    `)
})
})
function questionopen(){
    $(".question-cont").fadeIn(500);
    $(".firstdisplay").fadeOut(500);
}

function firstcancel(){
    $(".question-cont").fadeOut(500);
    $(".firstdisplay").fadeIn(500);
}

function packbuy(price,name,coin){
    $.post("https://frkn-vipsystem/checkCoin", JSON.stringify({ credit: parseInt(coin) ,price:price,name:name,buytype:"pack"}), function(x){
        if(x==true){
            $("body").css("display","none");
            $(".cases").css("display","none");
			$(".kazanilan").css("display","none");
			$(".container").css("display","none");
            $("#car-rentpage").animate({opacity: 1}, 1000);
            $(".page-carbuy").animate({opacity: 1}, 1000);
            $("#money-page").animate({opacity: 1}, 1000);
            $("#item-page").animate({opacity: 1}, 1000);
			$.post("https://frkn-vipsystem/close", JSON.stringify({}), function(x){});
        }
    });
}

function buytext(){
    $(".car-buy-cont").fadeIn(1000);
    $("#car-rentpage").animate({opacity: 0.5}, 1000);
    $(".page-carbuy").animate({opacity: 0.5}, 1000);
    $("#money-page").animate({opacity: 0.5}, 1000);
    $("#item-page").animate({opacity: 0.5}, 1000);
}

function cancel(){
    $(".car-buy-cont").fadeOut(1000);
    $("#car-rentpage").animate({opacity: 1}, 1000);
    $(".page-carbuy").animate({opacity: 1}, 1000);
    $("#money-page").animate({opacity: 1}, 1000);
    $("#item-page").animate({opacity: 1}, 1000);
}