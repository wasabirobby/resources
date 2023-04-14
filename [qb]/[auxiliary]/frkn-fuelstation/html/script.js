let body = document.getElementById("body");
let test = 0;
let level = 0;
window.addEventListener("message", function (event) {
  console.log(event.data.type);
  if (event.data.type == "admin") {
    document.getElementById("frknbody").style.display="block"
    document.getElementById("container-main").style.display = "none";
    document.getElementById("buy-container-main").style.display = "block";
    document.getElementById("slider-display").style.display = "none";
    document.getElementById("frame").style.display = "none";
  } else if (event.data.type == "close") {
    console.log("test");
    document.getElementById("frknbody").style.display="none"
  }
  else {
    $("#buy-container-main").hide();
  }
});
window.addEventListener("message", function (event) {
  $("#body").show();
  document.getElementById("container-main").style.display = "block";
});

function hiredata(){
  $("#hirecont").html('');

  $.post(
    `http://frkn-fuelstation/frknemp`,
    JSON.stringify({}),
    function (data) {
      $.each(data, function (index, value) {
               $("#hirecont").append(
                 `
                 <div class="hirelistcart">
                 <div class="hirename">`+value.firstname+` `+value.lastname+` `+value.dateofbirth+`</div> 
                 <div onclick="employeadd('`+value.firstname+`','`+value.identifier+`')" class="artı">+</div>
                 <hr> 
                 </div>
                `
               );
             });
    }
  );
}

function firedata(){
  $("#firecont").html('');
  $.post(
    `http://frkn-fuelstation/frknfire`,
    JSON.stringify({}),
    function (data) {
      $.each(data, function (index, value) {
               $("#firecont").append(
                 `
                 <div class="firelistcart">
                 <div class="hirename">`+value.name+` `+value.citizenid+`</div> 
                 <div onclick="employedelete('`+value.citizenid+`','`+value.name+`')" class="artı">-</div>
                 <hr> 
                 </div>
               `
               );
             });
    }
  );
}

function setwaypoint(){
  console.log("sdgd");
  $.post(`http://frkn-fuelstation/setpoint`,JSON.stringify({}),function (data) {})

}

function levelupdate(){
  $.post(
    `http://frkn-fuelstation/frknlevelupdate`,JSON.stringify({}),function (data) {
      console.log(JSON.stringify(data.level))
      let level = data.level
      document.getElementById("tanker-limit").innerHTML="Tanker Limit : " + data.tanker_limit

      if(level==1){
        document.getElementById("leveltankerprice").innerHTML=data.level1price
      }else if(level==2){
        document.getElementById("leveltankerprice").innerHTML=data.level2price
      }else if(level==3){
        document.getElementById("leveltankerprice").innerHTML=data.level3price
      }else if(level==4){
        document.getElementById("leveltankerprice").innerHTML=data.level4price
      }
      if(level==1){
        document.getElementById("level1").style.backgroundColor="#009D3E"
        document.getElementById("level1num").style.color="white"
        document.getElementById("level2").style.backgroundColor="#1f1e1e"
        document.getElementById("level2num").style.color="gray"
        document.getElementById("level3").style.backgroundColor="#1f1e1e"
        document.getElementById("level3num").style.color="gray"
        document.getElementById("level4").style.backgroundColor="#1f1e1e"
        document.getElementById("level4num").style.color="gray"
      }else if(level==2){
        document.getElementById("level2").style.backgroundColor="#009D3E"
        document.getElementById("level2num").style.color="white"
        document.getElementById("level1").style.backgroundColor="#1f1e1e"
        document.getElementById("level1num").style.color="gray"
        document.getElementById("level3").style.backgroundColor="#1f1e1e"
        document.getElementById("level3num").style.color="gray"
        document.getElementById("level4").style.backgroundColor="#1f1e1e"
        document.getElementById("level4num").style.color="gray"
      }else if (level==3){
        document.getElementById("level3").style.backgroundColor="#009D3E"
        document.getElementById("level3num").style.color="white"
        document.getElementById("level2").style.backgroundColor="#1f1e1e"
        document.getElementById("level2num").style.color="gray"
        document.getElementById("level1").style.backgroundColor="#1f1e1e"
        document.getElementById("level1num").style.color="gray"
        document.getElementById("level4").style.backgroundColor="#1f1e1e"
        document.getElementById("level4num").style.color="gray"
      }else if (level==4){
        document.getElementById("level4").style.backgroundColor="#009D3E"
        document.getElementById("level4num").style.color="white"
        document.getElementById("level3").style.backgroundColor="#1f1e1e"
        document.getElementById("level3num").style.color="gray"
        document.getElementById("level2").style.backgroundColor="#1f1e1e"
        document.getElementById("level2num").style.color="gray"
        document.getElementById("level1").style.backgroundColor="#1f1e1e"
        document.getElementById("level1num").style.color="gray"

      }
    }
  );
}

function historydata(){
  $("#history-main").html('');
  $.post(
    `http://frkn-fuelstation/frknhistory`,
    JSON.stringify({}),
    function (data) {
      $.each(data, function (index, value) {
               $("#history-main").append(
                 `
                 <tr>
                 <td class="user-td">
                 `+value.player_name+`
                   <hr class="buy-history-hr" />
                 </td>
                 <td class="date-td">`+value.plate+`</td>
                 <td class="vehicle-td">`+value.vehicle+`</td>
                 <td class="price-td">$`+value.price+`</td>
         
               <td>
                   <div id="container">
                     <label for="water">
                       <div id="fill"></div>
                     </label>
                     <span id="progress">50%</span>
                   </div>
                 </td>
               </tr>
               `
               );
             });
    }
  );
}


window.addEventListener("message",function(event){
  $("#stat").append(
    `
    <img onclick="setwaypoint()" class="set" src="../images/set.png">

    <div class="tankerheader">Information about the tanker</div>
        <div id="level1" class="level25"></div>
        <div id="level1num" class="level25text">1</div>
        <div id="level2" class="level50"></div>
        <div id="level2num" class="level50text">2</div>
         <div id="level3" class="level75"></div>
         <div id="level3num" class="level75text">3</div>
       <div id="level4" class="level100"></div> 
       <div id="level4num" class="level100text">4</div> 
       <div  onclick="update()" class="levelupdatebutton"></div> 
       <div class="levelupdatebuttontext">Update</div> 
       <div class="levelinfobutton"></div>
       <div class="levelinfobuttontext">Here you can increase your tanker level.</div>
       <hr class="priceinfohr">
       <div class="withtext">
        You can view and withdraw the money in the company vault here.
      <div id="companyprice" class="withprice">8965$</div>   
      <input onclick="withdraw()"  value="8965$"  id="withname" class="withchange" name="fname">
    </div>
        <div
        role="progressbar"
        aria-valuenow="65"
        aria-valuemin="0"
        aria-valuemax="100"

      ></div> 
   `
  );
    level = event.data.currentdata.level
    leveprice = event.data.currentdata
    data = event.data.currentdata
    document.getElementById("withname").value=event.data.currentdata.price+"$"
    document.getElementById("companyprice").innerHTML=event.data.currentdata.gas_station_revenue+"$"
    document.getElementById("tanker-limit").innerHTML="Tanker Limit : " + event.data.currentdata.tanker_limit
    document.getElementById("frknname").innerHTML=event.data.bank.name
    document.getElementById("bank").innerHTML=event.data.bank.bankbalance
    document.getElementById("cash").innerHTML=event.data.bank.cash
    if(level==1){
      document.getElementById("leveltankerprice").innerHTML=event.data.currentdata.level1price
    }else if(level==2){
      document.getElementById("leveltankerprice").innerHTML=event.data.currentdata.level2price
    }else if(level==3){
      document.getElementById("leveltankerprice").innerHTML=event.data.currentdata.level3price
    }else if(level==4){
      document.getElementById("leveltankerprice").innerHTML=event.data.currentdata.level4price
    }
    if(level==1){
      document.getElementById("level1").style.backgroundColor="#009D3E"
      document.getElementById("level1num").style.color="white"
    }else if(level==2){
      document.getElementById("level2").style.backgroundColor="#009D3E"
      document.getElementById("level2num").style.color="white"
    }else if (level==3){
      document.getElementById("level3").style.backgroundColor="#009D3E"
      document.getElementById("level3num").style.color="white"
    }else if (level==4){
      document.getElementById("level4").style.backgroundColor="#009D3E"
      document.getElementById("level4num").style.color="white"
    }
    if (event.data.currentdata.gas_station_revenue>20000 )  {
      document.getElementById("test").innerHTML = "<a style='color:green'>Good</a>";
    }else if (event.data.currentdata.gas_station_revenue>10000 && event.data.currentdata.gas_station_revenue<=20000) {
      document.getElementById("test").innerHTML = "<a style='color:orange'>Average</a>";
    }else if(event.data.currentdata.gas_station_revenue>5000 && event.data.currentdata.gas_station_revenue<=10000) {
      document.getElementById("test").innerHTML = "<a style='color:red'>Bad</a>";
    }else if(event.data.currentdata.gas_station_revenue<=5000) {
      document.getElementById("test").innerHTML = "<a style='color:red'>Very Bad</a>";
    } 

    if(event.data.currentdata.tanker_limit==2000){
      if(data.tanker>=0 && data.tanker<=500){
          document.getElementById("limit25").style.backgroundColor="#009D3E"
          document.getElementById("limit25text").style.color="white"
      }else if(data.tanker>=500 && data.tanker<=1000){
        document.getElementById("limit50").style.backgroundColor="#009D3E"
        document.getElementById("limit50text").style.color="white"
      }else if(data.tanker>=1000 && data.tanker<=1500){
        document.getElementById("limit75").style.backgroundColor="#009D3E"
        document.getElementById("limit75text").style.color="white"
      }else if(data.tanker>=1500 && data.tanker<=2000){
        document.getElementById("limit100").style.backgroundColor="#009D3E"
        document.getElementById("limit100text").style.color="white"
      }
    }


    if(event.data.currentdata.tanker_limit==4000){
      if(data.tanker>=0 && data.tanker<=1000){
          document.getElementById("limit25").style.backgroundColor="#009D3E"
          document.getElementById("limit25text").style.color="white"
      }else if(data.tanker>=1300 && data.tanker<=2000){
        document.getElementById("limit50").style.backgroundColor="#009D3E"
        document.getElementById("limit50text").style.color="white"
      }else if(data.tanker>=2000 && data.tanker<=3000){
        document.getElementById("limit75").style.backgroundColor="#009D3E"
        document.getElementById("limit75text").style.color="white"
      }else if(data.tanker>=3000 && data.tanker<=4000){
        document.getElementById("limit100").style.backgroundColor="#009D3E"
        document.getElementById("limit100text").style.color="white"
      }
    }


    if(event.data.currentdata.tanker_limit==6000){
      if(data.tanker>=0 && data.tanker<=1500){
          document.getElementById("limit25").style.backgroundColor="#009D3E"
          document.getElementById("limit25text").style.color="white"
      }else if(data.tanker>=1500 && data.tanker<=2000){
        document.getElementById("limit50").style.backgroundColor="#009D3E"
        document.getElementById("limit50text").style.color="white"
      }else if(data.tanker>=3000 && data.tanker<=4500){
        document.getElementById("limit75").style.backgroundColor="#009D3E"
        document.getElementById("limit75text").style.color="white"
      }else if(data.tanker>=4500 && data.tanker<=6000){
        document.getElementById("limit100").style.backgroundColor="#009D3E"
        document.getElementById("limit100text").style.color="white"
      }
    }


    if(event.data.currentdata.tanker_limit==8000){
      if(data.tanker>=0 && data.tanker<=2000){
          document.getElementById("limit25").style.backgroundColor="#009D3E"
          document.getElementById("limit25text").style.color="white"
      }else if(data.tanker>=2600 && data.tanker<=4000){
        document.getElementById("limit50").style.backgroundColor="#009D3E"
        document.getElementById("limit50text").style.color="white"
      }else if(data.tanker>=4000 && data.tanker<=6000){
        document.getElementById("limit75").style.backgroundColor="#009D3E"
        document.getElementById("limit75text").style.color="white"
      }else if(data.tanker>=6000 && data.tanker<=8000){
        document.getElementById("limit100").style.backgroundColor="#009D3E"
        document.getElementById("limit100text").style.color="white"
      }
    }

    if (data.level == 1) {
      let percent = (data.tanker / 2000) * 100;
      let ceil = Math.ceil(percent);
      var r = document.querySelector(":root");
      r.style.setProperty("--value", ceil);
      document.getElementById("total-turnover").innerHTML =
        `Total Turnover: ` + data.gas_station_revenue + ``;
      document.getElementById("tanker-limit").innerHTML = `Tanker Limit:2000 `;
     
    }
    if (data.level == 2) {
      let percent = (data.tanker / 4000) * 100;
      let ceil = Math.ceil(percent);
      var r = document.querySelector(":root");
      r.style.setProperty("--value", ceil);
      document.getElementById("total-turnover").innerHTML =
        `Total Turnover: ` + data.gas_station_revenue + ``;
      document.getElementById("tanker-limit").innerHTML = `Tanker Limit:4000 `;
     
    }
    if (data.level == 3) {
      let percent = (data.tanker / 6000) * 100;
      let ceil = Math.ceil(percent);
      var r = document.querySelector(":root");
      r.style.setProperty("--value", ceil);
      document.getElementById("tanker-limit").innerHTML = `Tanker Limit:6000 `;
      document.getElementById("total-turnover").innerHTML =
        `Total Turnover: ` + data.gas_station_revenue + ``;
     
    }
    if (data.level == 4) {
      let percent = (data.tanker / 8000) * 100;
      let ceil = Math.ceil(percent);
      var r = document.querySelector(":root");
      r.style.setProperty("--value", ceil);
      document.getElementById("tanker-limit").innerHTML = `Tanker Limit:6000 `;
      document.getElementById("total-turnover").innerHTML =
        `Total Turnover: ` + data.gas_station_revenue + ``;
    }


})

function openhomepage(){
  document.getElementById("newpage").style.display="block";
  document.getElementById("emp").style.display="none";
  document.getElementById("homepagetext").style.color = "green";
  document.getElementById("emppagetext").style.color = "white";
  document.getElementById("hridpage").style.display="none";
  document.getElementById("hrid").style.display="block";
  document.getElementById("change1").innerHTML="/ Dashboard"
  document.getElementById("change2").innerHTML="Dashboard"
}

function opennameinput(){ 
    document.getElementById("fname").style.display="block";
    document.getElementById("changebutton").style.display="block";
}

function openemgpage(){
  hiredata()
  firedata()
  historydata()
  document.getElementById("newpage").style.display="none";
  document.getElementById("emp").style.display="block";
  document.getElementById("hridpage").style.display="block";
  document.getElementById("emppagetext").style.color = "green";
  document.getElementById("homepagetext").style.color = "white";
  document.getElementById("hrid").style.display="none";
  document.getElementById("change1").innerHTML="/ Employee"
  document.getElementById("change2").innerHTML="Employee"
}

function employeadd(name, citizenid) {
      $.post(
        `http://frkn-fuelstation/employe`,
        JSON.stringify({ name: name, citizenid: citizenid }));
        hiredata();
        firedata()
}


var input = document.getElementById("fname");
input.addEventListener("keypress", function(event) {
  if (event.key === "Enter") {
    event.preventDefault();
    document.getElementById("changebutton").click();
  }
});

var withinput = document.getElementById("withname")
input.addEventListener("keypress",function(event){
  if(event.key=="Enter"){
    event.preventDefault()
    withdraw()
  }
})


function namechange(){
  let inputValue = document.getElementById("fname").value;
  Swal.fire({
    title: "Are you sure?",
    text: "Are you sure you want to change the name of the gas station?!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, change!",
  }).then((result) => {
    if (result.isConfirmed) {
      Swal.fire(
        "Changed!",
        "The name of the gas station has been changed.",
        "success"
      );
      $.post(`http://frkn-fuelstation/namechange`, JSON.stringify({inputValue:inputValue}));
    }
  });
}



function withdraw(){
  let price =  document.getElementById("withname").value
  console.log(price);
  Swal.fire({
    title: "Are you sure?",
    text: "Are you sure you want to withdraw the money from the company vault??!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, withdraw!",
  }).then((result) => {
    if (result.isConfirmed) {
      Swal.fire(
        "Fired!",
        "Money in company vault successfully transferred to your bank account..",
        "success"
      );
      $.post(`http://frkn-fuelstation/withdraw`, JSON.stringify({price:price}));
      setTimeout(() => {
        closeFunction();
      }, 2000);
    }
  });
}

function employedelete(citizenid,name) {
      $.post(`http://frkn-fuelstation/employe-delete`, JSON.stringify({citizenid:citizenid,name:name}));
        firedata();
        hiredata()
}


function transfer(citizenid){
  Swal.fire({
    title: "Are you sure?",
    text: "Are you sure you want to transfer your company?!",
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, fire!",
  }).then((result) => {
    if (result.isConfirmed) {
      Swal.fire(
        "Fired!",
        "Your company has been successfully transferred..",
        "success"
      );
      $.post(`http://frkn-fuelstation/transfer`, JSON.stringify({citizenid:citizenid}));
      setTimeout(() => {
        closeFunction();
      }, 1000);
    }
  });
}


function fill() {
  $.post(`http://frkn-fuelstation/fill`, JSON.stringify({}));
  closeFunction();
}

function update() {
  // Swal.fire({
  //   title: "Are you sure?",
  //   text: "Are you sure you want to upgrade?!",
  //   icon: "warning",
  //   showCancelButton: true,
  //   confirmButtonColor: "#3085d6",
  //   cancelButtonColor: "#d33",
  //   confirmButtonText: "Yes, raise!",
  // }).then((result) => {
  //   if (result.isConfirmed) {
  //     if (level == 4) {
  //       Swal.fire({
  //         icon: "error",
  //         title: "Oops...",
  //         text: "Your gas station is already at maximum!",
  //       });
  //     } else {
  //       Swal.fire(
  //         "Upgraded!",
  //         "Your gas station has been upgraded. Tanker storage capacity has been increased.",
  //         "success"
  //       );
        $.post(`http://frkn-fuelstation/update`, JSON.stringify({}));
        setTimeout(() => {
          levelupdate();
        }, 1000);
      // }
    // }
  // });

}

$(document).on('keydown', function() {
  switch(event.keyCode) {
      case 27: 
         closeFunction()
          break;
  }
});


function closeFunction() {
  document.getElementById("body").style.display = "none";

  $.post(`http://frkn-fuelstation/exit`, JSON.stringify({}));
}
function nuiclose(){
  $.post(`http://frkn-fuelstation/exit`, JSON.stringify({}));
}