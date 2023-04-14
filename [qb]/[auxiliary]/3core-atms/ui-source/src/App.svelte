<script>
	let playerData = [];
	let defaultData = [];
	let transferID;
	window.$(document).ready(function() {
		window.addEventListener('message', event => {
			let type = event.data.type;
			switch (type) {
				case 'buyAtm':
					window.$('.dialog-box').hide();
					window.$('.dark-wrapper').css('display', 'flex');
					window.$('.atm-container').hide();
					window.$('.buy-atm').css('display', 'flex');
					defaultData = event.data.defaultData;
					break;
				case 'showMenu':
					window.$('.dialog-box').hide();
					window.$('.dark-wrapper').css('display', 'flex');
					window.$('.buy-atm').css('display', 'none');
					window.$('.atm-container').show();
					playerData = event.data.playerData;
					defaultData = event.data.defaultData;
					transferID = null;
					break;
				case 'updatePlayerData':
					playerData['cash'] = event.data.playerData['cash'];
					playerData['balance'] = event.data.playerData['balance'];
					break;
				case 'updateATMBalance':
					defaultData['atmBalance'] = event.data.balance;
					break;
			}
		});
		window.$(document).keyup(function(e) {
			if (e.keyCode == 27) {
				window.$('.dark-wrapper').css('display', 'none');
				window.$('.dialog-buttons').empty();
				window.$.post('https://3core-atms/close', JSON.stringify({}));
			}
		});
	});
	function action(action) {
		switch (action) {
			case 'withdraw':
				window.$('.dialog-box').hide();
				window.$('.dialog-buttons').empty();
				window.$('.atm-container').show();
				window.$.post('https://3core-atms/withdraw', JSON.stringify({
					amount: window.$('.dialog-input').val()
				}));
				window.$('.dialog-input').val('');
				break;
			case 'deposit':
				window.$('.dialog-box').hide();
				window.$('.dialog-buttons').empty();
				window.$('.atm-container').show();
				window.$.post('https://3core-atms/deposit', JSON.stringify({
					amount: window.$('.dialog-input').val()
				}));
				window.$('.dialog-input').val('');
				break;
			case 'transfer-1':
				window.$('.dialog-box').hide();
				window.$('.dialog-buttons').empty();
				createDialog('Transfer money', 'Please type the amount you want to transfer', 'transfer', 'cancel', 'transfer-2', true);
				transferID = window.$('.dialog-input').val();
				break;
			case 'transfer-2':
				window.$('.dialog-box').hide();
				window.$('.dialog-buttons').empty();
				window.$('.atm-container').show();
				window.$.post('https://3core-atms/transfer', JSON.stringify({
					amount: window.$('.dialog-input').val(),
					id: transferID
				}));
				window.$('.dialog-input').val('');
				break;
			case 'robatm':
				window.$('.dialog-box').hide();
				window.$('.dialog-buttons').empty();
				window.$('.dark-wrapper').css('display', 'none');
				window.$.post('https://3core-atms/robatm', JSON.stringify({}));
				break;
			case 'balancewithdraw':
				window.$('.dialog-box').hide();
				window.$('.dialog-buttons').empty();
				window.$('.atm-container').show();
				window.$.post('https://3core-atms/balancewithdraw', JSON.stringify({
					amount: window.$('.dialog-input').val()
				}));
				window.$('.dialog-input').val('');
				break;
		}
	}
	function createDialog(title, desc, button1Text, button2Text, actionType, hasInput) {
		window.$('.dialog-box-header').text(title);
		window.$('.dialog-box-description').text(desc);
		if (!hasInput) {
			window.$('.dialog-input').hide();
		} else {
			window.$('.dialog-input').show();
		}
		window.$('.dialog-input').val('');
		var dialogButtons = '<button class="b-yellow">'+button1Text+'</button><button class="b-white">'+button2Text+'</button>';
		window.$('.dialog-buttons').append(dialogButtons);
		window.$('button.b-white').click(function() {
			window.$('.dialog-box').hide();
			window.$('.dialog-buttons').empty();
			window.$('.atm-container').show();
		})
		window.$('button.b-yellow').click(function() {
			action(actionType);
		})
		window.$('.dialog-box').css('display', 'flex');
	}
	function withdrawMoney() {
		window.$('.atm-container').hide();
		createDialog('Withdraw money', 'Please type the amount you want to withdraw', 'withdraw', 'cancel', 'withdraw', true);
	}
	function depositMoney() {
		window.$('.atm-container').hide();
		createDialog('Deposit money', 'Please type the amount you want to deposit', 'deposit', 'cancel', 'deposit', true);
	}
	function transferMoney() {
		window.$('.atm-container').hide();
		createDialog('Transfer money', 'Please type the ID of the person', 'next', 'cancel', 'transfer-1', true);
	}
	function robATM() {
		window.$('.atm-container').hide();
		createDialog('ATM Robbery', 'Are you sure you want to rob this ATM?', 'confirm', 'cancel', 'robatm', false);
	}
	function withdrawBalance() {
		window.$('.atm-container').hide();
		createDialog('Balance - '+defaultData['atmBalance']+'$', 'Please type the amount you want to withdraw', 'withdraw', 'cancel', 'balancewithdraw', true);
	}
	function buyATM() {
		window.$.post('https://3core-atms/buyATM', JSON.stringify({}));
	}
</script>

<main>
	<div class="dark-wrapper">
		<button class="buy-atm" on:click={() => buyATM()}>
			<img alt="" src="https://cdn.discordapp.com/attachments/1008791639646548078/1012439161573216256/unknown.png">
			<span>Buy this atm<br>for {defaultData['atmPrice']}$</span>
		</button>
		<div class="dialog-box">
			<p class="dialog-box-header"></p>
			<p class="dialog-box-description"></p>
			<input class="dialog-input" type="text">
			<div class="dialog-buttons"></div>
		</div>
		<div class="atm-container">
			<h1 class="atm-header">ATM<span>Account {playerData['name']}</span></h1>
			<div class="balance-wrapper">
				<p>Balance<span>{playerData['balance']}$</span></p>
				<p>Cash<span>{playerData['cash']}$</span></p>
				<p>Atm Owner<span>{defaultData['atmOwner']}</span></p>
				<p>Atm Fee<span>{defaultData['atmFee']}%</span></p>
			</div>
			<div class="atm-options">
				<button class="atm-option" on:click={() => withdrawMoney()}>
					<img alt="" src="https://cdn.discordapp.com/attachments/1008791639646548078/1012430010780495913/unknown.png">
					<span>Withdraw<br>money</span>
				</button>
				<button class="atm-option" on:click={() => depositMoney()}>
					<img alt="" src="https://cdn.discordapp.com/attachments/1008791639646548078/1012431250058920046/unknown.png">
					<span>Deposit<br>money</span>
				</button>
				<button class="atm-option" on:click={() => transferMoney()}>
					<img alt="" src="https://cdn.discordapp.com/attachments/1008791639646548078/1012431525511438346/unknown.png">
					<span>Transfer<br>money</span>
				</button>
				<button class="atm-option" on:click={() => robATM()}>
					<img alt="" src="https://cdn.discordapp.com/attachments/1008791639646548078/1012432000981942322/unknown.png">
					<span>Rob<br>atm</span>
				</button>
				{#if playerData['isOwner']}
					<button class="atm-option" on:click={() => withdrawBalance()}>
						<img alt="" src="https://cdn.discordapp.com/attachments/1008791639646548078/1012436267004338306/unknown.png">
						<span>Withdraw money<br>from the atm</span>
					</button>
				{/if}
			</div>
		</div>
	</div>
</main>

<style>
	@import url('https://fonts.cdnfonts.com/css/akrobat');
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
		justify-content: center;
		flex-direction: column;
		position: fixed;
		width: 100%;
		height: 100%;
		top: 0;
		left: 0;
		opacity: 0.9;
		background-image: linear-gradient(140deg, rgba(64, 107, 8, 0.30), rgba(68, 72, 72, 0.30)), url('https://cdn.discordapp.com/attachments/1008791639646548078/1012409591591616632/unknown.png');
		background-size: 100% 100%;
		background-repeat: no-repeat;
		user-select: none;
	}
	.atm-container {
		width: 100%;
		height: 100%;
		align-self: center;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.atm-header {
		align-self: center;
		font-size: 3vw;
		text-transform: uppercase;
		letter-spacing: 0.1vw;
		display: flex;
		flex-direction: column;
		text-align: center;
		color: white;
		position: absolute;
		top: 10vh;
	}
	.atm-header span {
		opacity: 0.4;
		font-size: 1.2vw;
	}
	.balance-wrapper {
		position: absolute;
		top: 25vh;
		width: 35vw;
		display: flex;
		justify-content: space-between;
		text-transform: uppercase;
		letter-spacing: .2em;
		font-size: 0.9vw;
		align-self: center;
		color: #bebebe;
	}
	.balance-wrapper p {
		display: flex;
		flex-direction: column;
		text-align: center
	}
	.balance-wrapper p span {
		color: white;
		font-size: 1.5vw;
		letter-spacing: 0
	}
	.atm-options {
		align-self: center;
		position: absolute;
		top: 37vh;
		display: flex;
		flex-direction: column;
		gap: 1.5vh;
	}
	.atm-option {
		border: none;
		width: 35vw;
		height: 10vh;
		background: linear-gradient(135deg, hsla(0, 0%, 100%, .1), hsla(0, 0%, 100%, 0));
		color: white;
		font-size: 1.2vw;
		letter-spacing: 0.2vw;
		text-transform: uppercase;
		text-align: left;
		cursor: pointer;
		display: flex;
		padding-left: 2vw;
		align-items: center;
	}
	.atm-option:hover {
		background: linear-gradient(135deg, rgba(64, 107, 8, 0.30), rgba(68, 72, 72, 0.0));
		transform: scale(1.1);
	}
	.atm-option img {
		width: 2vw;
		height: 4vh;
		align-self: center;
		margin-right: 16px
	}
	.buy-atm {
		align-self: center;
		border: none;
		width: 35vw;
		height: 10vh;
		background: linear-gradient(135deg, hsla(0, 0%, 100%, .1), hsla(0, 0%, 100%, 0));
		color: white;
		font-size: 1.2vw;
		letter-spacing: 0.2vw;
		text-transform: uppercase;
		text-align: left;
		cursor: pointer;
		display: none;
		padding-left: 2vw;
		align-items: center;
	}
	.buy-atm:hover {
		transform: scale(1.3);
	}
	.buy-atm img {
		width: 2vw;
		height: 4vh;
		align-self: center;
		margin-right: 16px
	}
	.dialog-box {
		position: absolute;
		align-self: center;
		background-size: 100% 100%;
		width: 35vw;
		height: 30vh;
		display: none;
		flex-direction: column;
		align-items: center;
		justify-content: space-evenly;
		color: white;
	}
	.dialog-box-header {
		text-align: center;
		font-size: 2.5vw;
		text-transform: uppercase
	}
	.dialog-box-description {
		text-align: center;
		max-height: 33vh;
		font-size: 1vw;
		overflow: auto
	}
	.dialog-buttons {
		display: flex;
		align-items: center;
		justify-content: center;
	}
	:global(.dialog-buttons > button) {
		font-family: 'Akrobat Black', sans-serif;
		width: 10vw;
		height: 7vh;
		border: none;
		display: flex;
		justify-content: center;
		align-items: center;
		text-align: center;
		border-radius: 0.3vw;
		color: white;
		text-transform: uppercase;
		font-size: 1.5vw;
		margin-right: 2vw;
		transition: transform .23232323s ease-in-out;
		-webkit-transition: transform .23232323s ease-in-out;
		-moz-transition: transform .23232323s ease-in-out;
		cursor: pointer;
	}
	:global(.dialog-buttons > button:last-child) {
		margin-right: 0
	}
	:global(.dialog-buttons > button.b-yellow) {
		background: green;
		color: white
	}
	:global(.dialog-buttons > button.b-white) {
		background: hsla(0, 0%, 100%, 0.1);
		color: white
	}
	:global(.dialog-buttons > button:hover) {
		transform: scale(1.1);
	}
	.dialog-box .dialog-input {
		outline: none !important;
		width: 20vw;
		height: 8vh;
		background: rgba(0, 0, 0, 0.3);
		border: none;
		border-radius: 0.3vw;
		text-align: center;
		color: white;
		font-size: 1vw;
		letter-spacing: 0.1vw
	}
</style>