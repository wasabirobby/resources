<script>
	import Lock from "svelte-material-icons/Lock.svelte";
	import Camera from "svelte-material-icons/Camera.svelte";
	import CrosshairsGps from "svelte-material-icons/CrosshairsGps.svelte";
	import Remote from "svelte-material-icons/Remote.svelte";

	let currentPlanStyle = {
		'color': '#b17efe', 
		'border': '0.2vw solid #b17efe', 
		'pointer-events': 'none'
	}

	let defaultStyle = {
		'color': '#60ffc6',
		'border': '0.2vw solid #60ffc6',
		'pointer-events': 'auto'
	}

	let ownedVehicles = [];

	let avaibleVehicles = [];

	let currentPage;

	function updatePlan(plan, prices) {
		switch (plan) {
			case 'basic':
				window.$('.insurance-button.basic').text('Your current plan').css(currentPlanStyle);
				window.$('.insurance-button.standart').text('Upgrade To '+prices['standart']+' - 2000$');
				window.$('.insurance-button.premium').text('Upgrade To '+prices['premium']+' - 4000$');
				window.$('.insurance-button.standart').css(defaultStyle);
				window.$('.insurance-button.premium').css(defaultStyle);
				break;
			case 'standart':
				window.$('.insurance-button.standart').text('Your current plan').css(currentPlanStyle);
				window.$('.insurance-button.basic').text('Downgrade to basic - '+prices['basic']+'$');
				window.$('.insurance-button.premium').text('Upgrade To Premium - '+prices['premium']+'$');
				window.$('.insurance-button.basic').css(defaultStyle);
				window.$('.insurance-button.premium').css(defaultStyle);
				break;
			case 'premium':
				window.$('.insurance-button.premium').text('Your current plan').css(currentPlanStyle);
				window.$('.insurance-button.basic').text('Downgrade to basic - '+prices['basic']+'$');
				window.$('.insurance-button.standart').text('Downgrade to standart - '+prices['standart']+'$');
				window.$('.insurance-button.basic').css(defaultStyle);
				window.$('.insurance-button.standart').css(defaultStyle);
				break;
			default:
				window.$('.insurance-button.basic').text('Upgrade to basic - '+prices['basic']+'$').css(defaultStyle);
				window.$('.insurance-button.standart').text('Upgrade to standart - '+prices['standart']+'$').css(defaultStyle);
				window.$('.insurance-button.premium').text('Upgrade To Premium - '+prices['premium']+'$').css(defaultStyle);
		}
	}

	window.$(document).ready(function() {
		window.addEventListener('message', event => {
			let type = event.data.type;
			if (type == 'show') {
				window.$('.dark-wrapper').show();
				updatePlan(event.data.plan, event.data.prices);
				ownedVehicles = event.data.ownedVehicles;
				currentPage = 'insurance-menu';
			} else if (type == 'update') {
				updatePlan(event.data.plan, event.data.prices);
				ownedVehicles = event.data.ownedVehicles;
				avaibleVehicles = event.data.avaibleVehicles;
			} else if (type == 'control') {
				window.$('.vehicle-control').css('display', 'flex');
				avaibleVehicles = event.data.vehicles;
				currentPage = 'control-menu';
			}
		});
		window.$('.insurance-button.basic').click(function() {
			window.$.post('https://3core-insurance/buyInsurance', JSON.stringify({
				level: 'basic'
			}));
		});
		window.$('.insurance-button.standart').click(function() {
			window.$.post('https://3core-insurance/buyInsurance', JSON.stringify({
				level: 'standart'
			}));
		});
		window.$('.insurance-button.premium').click(function() {
			window.$.post('https://3core-insurance/buyInsurance', JSON.stringify({
				level: 'premium'
			}));
		});
		window.$(document).keyup(function(e) {
			if (e.keyCode == 27) {
				switch (currentPage) {
					case 'insurance-menu':
						window.$('.dark-wrapper').hide();
						window.$.post('https://3core-insurance/close', JSON.stringify({}));
						break;
					case 'control-menu':
						window.$('.vehicle-control').hide();
						window.$.post('https://3core-insurance/close', JSON.stringify({}));
						break;
				}
			}
		});
	});

	function updateUpgrade(vehicle, upgrade, value) {
		window.$.post('https://3core-insurance/updateUpgrade', JSON.stringify({
			vehicle: vehicle,
			upgrade: upgrade,
			value: value
		}));
	}

	function activeOption(vehicle, type) {
		window.$.post('https://3core-insurance/activeOption', JSON.stringify({
			vehicle: vehicle,
			type: type
		}));
	}
</script>

<main>
	<div class="dark-wrapper">
		<div class="insurance-wrapper">
			<i class="insurance-bg-image"></i>
			<h1 class="insurance-label">Choose your insurance<div class="bottom-border"></div></h1>
			<div class="insurance-options">
				<div class="option">
					<h1 class="option-label">Basic Plan</h1>
					<ul>
						<li>Vehicle Lock System</li>
                        <li>Vehicle Camera System</li>
                        <li class="locked">Vehicle GPS System</li>
                        <li class="locked">Vehicle Remote Control</li>
					</ul>
					<button class="insurance-button basic">Upgrade To Basic - 1000$</button>
				</div>
				<div class="option">
					<h1 class="option-label">Standart Plan</h1>
					<ul>
                        <li>Vehicle Lock System</li>
                        <li>Vehicle Camera System</li>
                        <li>Vehicle GPS System</li>
                        <li class="locked">Vehicle Remote Control</li>
                    </ul>
					<button class="insurance-button standart">Upgrade To Standart - 2000$</button>
				</div>
				<div class="option">
					<h1 class="option-label">Premium Plan</h1>
					<ul>
                        <li>Vehicle Lock System</li>
                        <li>Vehicle Camera System</li>
                        <li>Vehicle GPS System</li>
                        <li>Vehicle Remote Control</li>
                    </ul>
					<button class="insurance-button premium">Upgrade To Premium - 4000$</button>
				</div>
			</div>
			<h1 class="manage-label">Manage your vehicles<div class="bottom-border"></div></h1>
			<div class="owned-vehicles">
				{#each ownedVehicles as vehicle}
					<div class="vehicle">
						<h1 class="vehicle-name">{vehicle['Name']}</h1>
						<div class="buttons">
							{#if vehicle['Insurance'] == 'basic'}
								<button on:click={() => updateUpgrade(vehicle['Hash'], 'lock', vehicle['Upgrade']['Lock'])} class={vehicle['Upgrade']['Lock'] ? 'active' : 'default'}><Lock/></button>
								<button on:click={() => updateUpgrade(vehicle['Hash'], 'camera', vehicle['Upgrade']['Camera'])} class={vehicle['Upgrade']['Camera'] ? 'active' : 'default'}><Camera/></button>
							{:else if vehicle['Insurance'] == 'standart'}
								<button on:click={() => updateUpgrade(vehicle['Hash'], 'lock', vehicle['Upgrade']['Lock'])} class={vehicle['Upgrade']['Lock'] ? 'active' : 'default'}><Lock/></button>
								<button on:click={() => updateUpgrade(vehicle['Hash'], 'camera', vehicle['Upgrade']['Camera'])} class={vehicle['Upgrade']['Camera'] ? 'active' : 'default'}><Camera/></button>
								<button on:click={() => updateUpgrade(vehicle['Hash'], 'gps', vehicle['Upgrade']['Gps'])} class={vehicle['Upgrade']['Gps'] ? 'active' : 'default'}><CrosshairsGps/></button>
							{:else if vehicle['Insurance'] == 'premium'}
								<button on:click={() => updateUpgrade(vehicle['Hash'], 'lock', vehicle['Upgrade']['Lock'])} class={vehicle['Upgrade']['Lock'] ? 'active' : 'default'}><Lock/></button>
								<button on:click={() =>updateUpgrade(vehicle['Hash'], 'camera', vehicle['Upgrade']['Camera'])} class={vehicle['Upgrade']['Camera'] ? 'active' : 'default'}><Camera/></button>
								<button on:click={() => updateUpgrade(vehicle['Hash'], 'gps', vehicle['Upgrade']['Gps'])} class={vehicle['Upgrade']['Gps'] ? 'active' : 'default'}><CrosshairsGps/></button>
								<button on:click={() => updateUpgrade(vehicle['Hash'], 'remote', vehicle['Upgrade']['Remote'])} class={vehicle['Upgrade']['Remote'] ? 'active' : 'default'}><Remote/></button>
							{/if}
						</div>
					</div>
				{/each}
			</div>
		</div>
	</div>
	<div class="vehicle-control">
		<h1 class="avaible-vehicles">Avaible vehicles</h1>
		{#each avaibleVehicles as vehicle}
			<div class="avaible-vehicle">
				<h1 class="vehicle-name">{vehicle['Name']}</h1>
				<div class="buttons vehicles">
					{#if vehicle['Insurance'] == 'basic'}
						<button on:click={() => activeOption(vehicle['Hash'], 'lock')} class={vehicle['Options']['lock'] ? 'active' : 'default-pointer'}><Lock/></button>
						<button on:click={() => activeOption(vehicle['Hash'], 'camera')} class={vehicle['Options']['camera'] ? 'active' : 'default-pointer'}><Camera/></button>
					{:else if vehicle['Insurance'] == 'standart'}
						<button on:click={() => activeOption(vehicle['Hash'], 'lock')} class={vehicle['Options']['lock'] ? 'active' : 'default-pointer'}><Lock/></button>
						<button on:click={() => activeOption(vehicle['Hash'], 'camera')} class={vehicle['Options']['camera'] ? 'active' : 'default-pointer'}><Camera/></button>
						<button on:click={() => activeOption(vehicle['Hash'], 'gps')} class={vehicle['Options']['gps'] ? 'active' : 'default-pointer'}><CrosshairsGps/></button>
					{:else if vehicle['Insurance'] == 'premium'}
						<button on:click={() => activeOption(vehicle['Hash'], 'lock')} class={vehicle['Options']['lock'] ? 'active' : 'default-pointer'}><Lock/></button>
						<button on:click={() => activeOption(vehicle['Hash'], 'camera')} class={vehicle['Options']['camera'] ? 'active' : 'default-pointer'}><Camera/></button>
						<button on:click={() => activeOption(vehicle['Hash'], 'gps')} class={vehicle['Options']['gps'] ? 'active' : 'default-pointer'}><CrosshairsGps/></button>
						<button on:click={() => activeOption(vehicle['Hash'], 'remote')} class={vehicle['Options']['remote'] ? 'active' : 'default-pointer'}><Remote/></button>
					{/if}
				</div>
			</div>
		{/each}
	</div>
</main>

<style>
	@import url('http://fonts.cdnfonts.com/css/akrobat');
	* {
		padding: 0;
		margin: 0;
		font-family: 'Akrobat Black', sans-serif;
		transition: transform .23232323s ease-in-out;
		-webkit-transition: transform .23232323s ease-in-out;
		-moz-transition: transform .23232323s ease-in-out;
	}
	.dark-wrapper {
		display: none;
		position: fixed;
		width: 100%;
		height: 100%;
		top: 0;
		left: 0;
		opacity: 0.9;
		background: linear-gradient(140deg, #203939, #394160);
		user-select: none;
	}
	.insurance-wrapper {
		display: flex;
		flex-direction: column;
		height: 100%;
		width: 100%;
	}
	.insurance-bg-image {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		pointer-events: none;
		background: url('https://cdn.discordapp.com/attachments/932352790334955621/1006558290953638039/unknown.png');
		background-size: 100% 100%;
	}
	.insurance-label {
		position: fixed;
		top: 3vh;
		left: 5vw;
		color: white;
		text-transform: uppercase;
		font-size: 10vh;
		letter-spacing: 0.2vw;
		font-style: italic;
		text-shadow: 0 0 50px black;
	}
	.bottom-border {
		width: 60%;
		border-bottom: 0.4vw solid white;
		border-radius: 0.3vw;
	}
	.insurance-options {
		margin-bottom: 20vh;
		width: 65%;
		height: 100%;
		display: flex;
		margin-left: 3vw;
		align-items: center;
		gap: 2vw;
	}
	.option {
		height: 50%;
		width: 30%;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	.option-label {
		color: white;
		font-size: 5vh;
		text-shadow: 0 0 50px black;
		text-transform: uppercase;
		letter-spacing: 0.1vw;
		font-style: italic;
	}
	ul {
		margin-top: 3vh;
		display: flex;
		align-items: center;
		flex-direction: column;
	}
	li {
		color: white;
		font-size: 1.5vw;
		letter-spacing: 0.1vw;
		text-shadow: 0 0 50px black;
		text-transform: uppercase;
	}
	.locked {
		color: hsla(0, 0%, 100%, .2);
	}
	.insurance-button {
		margin-top: 3vh;
		width: 100%;
		height: 6vh;
		border-radius: 0.3vw;
		background-color: unset;
		border: none;
		font-size: 1vw;
		color:#60ffc6;
		border: 0.2vw solid #60ffc6;
		letter-spacing: 0.1vw;
		text-transform: uppercase;
	}
	.insurance-button:hover {
		transform: scale(1.1);
	}
	.manage-label {
		position: fixed;
		bottom: 35vh;
		left: 3vw;
		color: white;
		text-transform: uppercase;
		font-size: 8vh;
		letter-spacing: 0.2vw;
		font-style: italic;
		text-shadow: 0 0 50px black;
	}
	.owned-vehicles {
		position: fixed;
		overflow: auto;
		bottom: 0;
		left: 3vw;
		width: 50%;
		height: 32%;
	}
	.vehicle {
		margin-bottom: 2.5vh;
		display: flex;
		align-items: center;
		justify-content: space-between;
		border: 0.2vw solid #3d91db;
		border-radius: 0.3vw;
		width: 70%;
		height: 40%;
	}
	.vehicle-name {
		color: white;
		font-size: 2vw;
		letter-spacing: 0.1vw;
		margin-left: 1vw;
		text-transform: uppercase;
		text-shadow: 0 0 50px black;
	}
	.vehicle-control .vehicle-name {
		font-size: 1.5vw;
	}
	.buttons {
		display: flex;
		gap: 1vw;
		margin-right: 1vw;
	}
	.buttons button {
		display: flex;
		align-items: center;
		justify-content: center;
		border: none;
		color: white;
		border-radius: 0.3vw;
		width: 4vw;
		height: 6vh;
		font-size: 1.5vw;
	}
	.buttons.vehicles {
		gap: 0.5vw;
	}
	.buttons.vehicles button {
		width: 2.5vw;
		height: 4.5vh;
	}
	.active {
		background: #3d91db;
		pointer-events: auto;
	}
	.default {
		background: hsla(0, 0%, 100%, .2);
	}
	.default-pointer {
		background: hsla(0, 0%, 100%, .2);
		pointer-events: none;
	}
	.buttons button:hover {
		transform: scale(1.1);
	}
	.owned-vehicles::-webkit-scrollbar {
		display: none;
	}
	.vehicle-control {
		position: fixed;
		display: none;
		flex-direction: column;
		align-items: center;
		gap: 1vh;
		right: 0;
		top: 0;
		margin: 1vw;
		width: 20%;
		height: 100%;
		user-select: none;
	}
	.avaible-vehicle {
		display: flex;
		justify-content: space-between;
		align-items: center;
		background-color: #0d47a1;
		width: 100%;
		height: 8vh;
		border-radius: 0.3vw;
	}
	.avaible-vehicles {
		color: white;
		font-size: 2vw;
		letter-spacing: 0.1vw;
		text-transform: uppercase;
		text-shadow: 0 0 50px black;
	}
</style>