<script>
	let pageIndex = 0;
	let investments = [];
	let canInvest1; let canInvest2;
	let categoryChosen = 1;
	let showTime = false;
	function calcScreenZoom() {
		var zoomValWidth = document.body.clientWidth / 1920;
		var zoomValHeight = document.body.clientHeight / 1080;
		if (zoomValWidth < zoomValHeight) {
			return zoomValWidth;
		} else {
			return zoomValHeight;
		}
	}
	function switchPage(newIndex) {
		pageIndex = newIndex;
	}
	function startInvestment(investmentData, index, type) {
		investmentData['Index'] = index;
		investmentData['Type'] = type;
		window.$.post('https://3core-investments/startInvestment', JSON.stringify({
			investmentData: investmentData
		}));
	}
	function getRemainTime(type, hours, remainTime) {
		if (type == 1) {
			let hoursLeft = parseInt(Math.floor(remainTime / 3600));
			if (hoursLeft < 60) {
				return ''+Math.floor(remainTime / 60)+' minutes'
			} else {
				return ''+hoursLeft+' hours';
			}
		} else if (type == 2) {
			return parseInt(((remainTime / (hours * 3600)) * 100).toFixed());
		}
	}
	function takeProfit(type) {
		window.$.post('https://3core-investments/takeProfit', JSON.stringify({
			type: type
		}));
	}
	function getClass(investment) {
		if (investment['Active']) {
			if (investment['RemainTime'] == 0) {
				return 'investments-list-item take';
			} else {
				return 'investments-list-item active';
			}
		} else {
			return 'investments-list-item'
		}
	}
	function secToTable(secs) {
		var sec_num = parseInt(secs, 10);
		var hours = Math.floor(sec_num / 3600);
		var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
		if (hours < 10) {hours = "0"+hours;}
		if (minutes < 10) {minutes = "0"+minutes;}
		return hours+':'+minutes;
	}
	function checkForActive(table) {
		let found = false;
		for (let idx = 0; idx < table.length; idx++) {
			if (table[idx]['Active'] && table[idx['RemainTime']] != 0) {
				found = true;
			}
		}
		return found;
	}
	window.$(document).ready(function() {
		window.addEventListener('message', event => {
			let type = event.data.type;
			switch (type) {
				case 'showPage':
					window.$('main').show();
					window.$('.investments-wrapper').css('zoom', calcScreenZoom());
					investments = event.data.investments;
					canInvest1 = event.data.canInvest1;
					canInvest2 = event.data.canInvest2;
					break;
				case 'update':
					investments = event.data.investments;
					canInvest1 = event.data.canInvest1;
					canInvest2 = event.data.canInvest2;
					break;
				case 'showTime':
					showTime = true;
					break;
				case 'hideTime':
					showTime = false;
					break;
				case 'updateInvestments':
					investments = event.data.investments;
					break;
			}
		});
		window.$(document).keyup(function(e) {
			if (e.keyCode == 27) {
				window.$('main').hide();
				window.$.post('https://3core-investments/close', JSON.stringify({}));
			}
		});
	});
</script>

<main>
	<i class="investments-bg"></i>
	<div class="investments-wrapper">
		{#if pageIndex == 0}
			<p class="investments-center-text">Investments</p>
			<div class="investments-option-left" on:click={() => switchPage(1)}><p>Daytime<span>Free</span></p></div>
			<div class="investments-option-right" on:click={() => switchPage(2)}><p><span>from 1 day to 100 days</span>Long-term</p></div>
		{:else if pageIndex == 1}
			<div class="investments-page-wrapper">
				<div class="investments-page-wrapper-top">
					<div class="investments-goback" on:click={() => switchPage(0)}>
						<p>To the choice of investments</p>
					</div>
					<p class="investments-page-header">Daytime</p>
				</div>
				<div class="investments-list-wrapper">
					{#each investments['DayTime'] as investment, index}
						<div class={getClass(investment)}>
							<img alt="" src={investment['ImgLink']}>
							<div class="investments-item-content">
								<p class="investments-item-name">Investment #{index + 1}</p>
								<p class="investments-item-description">This investment will bring you ${investment['Profit']} net profit in {investment['Hours']} hours</p>
								<div class="investments-item-time-wrapper">
									<p class="investments-item-time">Duration <span>{investment['Hours']} hours</span></p>
								</div>
							</div>
							<div class="investments-item-content-right">
								<div class="investments-item-profit">
									<p class="investments-item-profit-val">Profit<span>${investment['Profit']}</span></p>
									<p class="investments-item-profit-val-green">+${investment['Profit']}</p>
								</div>
								{#if canInvest1}
									<div class="investments-item-button">
										<button on:click={() => startInvestment(investment, index + 1, 'DayTime')}>Invest</button>
									</div>
								{:else if investment['Active']}
									<div class="investments-item-button">
										{#if investment['RemainTime'] == 0}
											<button on:click={() => takeProfit('DayTime')}>Take profit</button>
										{:else}
											<div class="investments-item-progress">
												<p>Time left<br>to get profit<span>{getRemainTime(1, investment['Hours'], investment['RemainTime'])}</span></p>
												<div class="investments-item-progressbar">
													<span class="gray" style="height: {getRemainTime(2, investment['Hours'], investment['RemainTime'])}%;"></span>
													<span class="green" style="height: {100 - getRemainTime(2, investment['Hours'], investment['RemainTime'])}%;"></span>
												</div>
											</div>
										{/if}
									</div>
								{/if}
							</div>
						</div>
					{/each}
				</div>
			</div>
		{:else if pageIndex == 2}
			<div class="investments-page-wrapper">
				<div class="investments-page-wrapper-top">
					<div class="investments-goback" on:click={() => switchPage(0)}>
						<p>To the choice of investments</p>
					</div>
					<div class="investments-page-header-wrapper">
						<p class="investments-page-header">Long-Term</p>
						<ul class="investments-page-days">
							<li class={categoryChosen == 1 ? 'active' : ''} on:click={() => categoryChosen = 1}>100 hours</li>
							<li class={categoryChosen == 2 ? 'active' : ''} on:click={() => categoryChosen = 2}>200 hours</li>
							<li class={categoryChosen == 3 ? 'active' : ''} on:click={() => categoryChosen = 3}>300 hours</li>
							<li class={categoryChosen == 4 ? 'active' : ''} on:click={() => categoryChosen = 4}>400 hours</li>
							<li class={categoryChosen == 5 ? 'active' : ''} on:click={() => categoryChosen = 5}>500 hours</li>
						</ul>
					</div>
				</div>
				<div class="investments-list-wrapper">
					{#each investments['LongTerm'] as investment, index}
						{#if investment['Hours'] == categoryChosen * 100}
						<div class={getClass(investment)}>
								<img alt="" src={investment['ImgLink']}>
								<div class="investments-item-content">
									<p class="investments-item-name">Investment #{index + 1}</p>
									<p class="investments-item-description">You invest ${investment['Cost']} and in {investment['Hours']} hours you get your money back and an additional ${investment['Profit']}</p>
									<div class="investments-item-time-wrapper">
										<p class="investments-item-time">Duration <span>{investment['Hours']} hours</span></p>
									</div>
								</div>
								<div class="investments-item-content-right">
									<div class="investments-item-profit">
										<p class="investments-item-profit-val">Cost<span>${investment['Cost']}</span></p>
										<p class="investments-item-profit-val-green">+${investment['Profit']}</p>
									</div>
									{#if canInvest2}
										<div class="investments-item-button">
											<button on:click={() => startInvestment(investment, index + 1, 'LongTerm')}>Invest</button>
										</div>
									{:else if investment['Active']}
										<div class="investments-item-button">
											{#if investment['RemainTime'] == 0}
												<button on:click={() => takeProfit('LongTerm')}>Take profit</button>
											{:else}
												<div class="investments-item-progress">
													<p>Time left<br>to get profit<span>{getRemainTime(1, investment['Hours'], investment['RemainTime'])}</span></p>
													<div class="investments-item-progressbar">
														<span class="gray" style="height: {getRemainTime(2, investment['Hours'], investment['RemainTime'])}%;"></span>
														<span class="green" style="height: {100 - getRemainTime(2, investment['Hours'], investment['RemainTime'])}%;"></span>
													</div>
												</div>
											{/if}
										</div>
									{/if}
								</div>
							</div>
						{/if}
					{/each}
				</div>
			</div>
		{/if}
	</div>
</main>

{#if showTime}
	{#if checkForActive(investments['DayTime'])}
		{#each investments['DayTime'] as investment}
			{#if investment['Active']}
				<div class="active-investments">
					<p>Remaining<span>{secToTable(investment['RemainTime'])}</span><span class="span">Before receiving</span></p>
					<div class="active-investments-text">
						<p>{investment['Profit']}$</p>
					</div>
					<img alt="" src="https://cdn.discordapp.com/attachments/928768829675429938/1018147353854750790/unknown.png">
				</div>
			{/if}
		{/each}
	{:else if checkForActive(investments['LongTerm'])}
		{#each investments['LongTerm'] as investment}
			{#if investment['Active']}
				<div class="active-investments">
					<p>Remaining<span>{secToTable(investment['RemainTime'])}</span><span class="span">Before receiving</span></p>
					<div class="active-investments-text">
						<p>{investment['Cost'] + investment['Profit']}$</p>
					</div>
					<img alt="" src="https://cdn.discordapp.com/attachments/928768829675429938/1018147353854750790/unknown.png">
				</div>
			{/if}
		{/each}
	{/if}
{/if}

<style>
	@import url('http://fonts.cdnfonts.com/css/akrobat');
	* {
		padding: 0; margin: 0;
		user-select: none;
		font-family: 'Akrobat', sans-serif;
		font-size: 18px;
		overflow: hidden;
		transition: transform .24s ease-in-out;
		-webkit-transition: transform .24s ease-in-out;
		-moz-transition: transform .4s ease-in-out;
		box-sizing: border-box;
	}
	main {
		display: none;
	}
	.investments-wrapper {
		width: 100%; height: 100%;
		display: flex; justify-content: center; align-items: center;
		position: absolute;
		top: 0; left: 0;
	}
	.investments-bg {
		position: fixed;
		width: 100%; height: 100%;
		top: 0; left: 0;
		background: linear-gradient(135deg, #203939, #394160);
	}
	.investments-center-text {
		font-weight: 900; font-size: 108px;
		text-transform: uppercase;
		color: #fff;
	}
	.investments-option-left {
		position: absolute;
		display: flex; align-items: center;
		left: 74px;
		cursor: pointer;
	}
	.investments-option-left > p {
		font-weight: 900; font-size: 44px;
		text-transform: uppercase;
		color: #fff;
	}
	.investments-option-left > p > span {
		display: block;
		color: #fff;
		font-size: 18px; font-weight: 800;
		text-transform: uppercase;
		background: linear-gradient(90deg, #9ed347, #7fa95e);
		border-radius: 8px;
		width: fit-content; height: 30px;
		padding-left: 12px; padding-right: 12px; margin-top: 18px;
		display: flex; justify-content: center; align-items: center;
	}
	.investments-option-left::before {
		content: "";
		background: url('https://cdn.discordapp.com/attachments/928768829675429938/1016713747450052648/unknown.png');
		background-repeat: no-repeat; background-size: 100% 100%;
		width: 110px; height: 110px;
		margin-right: 79px;
	}
	.investments-option-left:hover {
		transform: translateX(-10px);
	}
	.investments-option-right {
		position: absolute;
		display: flex; align-items: center;
		right: 74px;
		cursor: pointer;
	}
	.investments-option-right > p {
		font-weight: 900; font-size: 44px;
		text-transform: uppercase;
		color: #fff;
	}
	.investments-option-right > p > span {
		display: block;
		color: black;
		font-size: 18px; font-weight: 800;
		text-transform: uppercase;
		background: #ffde2a;
		border-radius: 8px;
		width: fit-content; height: 30px;
		padding-left: 12px; padding-right: 12px; margin-bottom: 18px;
		display: flex; justify-content: center; align-items: center;
	}
	.investments-option-right::after {
		content: "";
		background: url('https://cdn.discordapp.com/attachments/928768829675429938/1016713747450052648/unknown.png');
		background-repeat: no-repeat; background-size: 100% 100%;
		width: 110px; height: 110px;
		margin-left: 79px;
		transform: rotate(180deg);
	}
	.investments-option-right:hover {
		transform: translateX(10px);
	}
	.investments-page-wrapper {
		width: 100%; height: 100%;
		display: flex; justify-content: center; align-items: center; flex-direction: column;
	}
	.investments-page-wrapper-top {
		display: flex; align-items: center;
	}
	.investments-goback {
		display: flex; align-items: center;
		position: absolute;
		left: 120px;
		cursor: pointer;
	}
	.investments-goback:hover {
		transform: translateX(-10px);
	}
	.investments-goback > p {
		font-size: 32px; font-weight: 600;
		color: #fff;
	}
	.investments-goback::before {
		content: "";
		background: url('https://cdn.discordapp.com/attachments/928768829675429938/1016713747450052648/unknown.png');
		background-repeat: no-repeat;
		background-size: 100% 100%;
		width: 44px; height: 44px;
		margin-right: 24px;
	}
	.investments-page-header {
		font-weight: 900; font-size: 80px;
		text-transform: uppercase;
		color: #fff;
	}
	.investments-list-wrapper {
		min-height: 700px; max-height: 700px; width: 1300px;
		overflow: auto;
		position: relative;
		margin-top: 80px; padding-right: 10px;
		display: grid; gap: 12px;
	}
	.investments-list-item {
		background: rgba(0, 0, 0, 0.18);
		border-radius: 10px;
		width: 100%; height: 210px;
		display: flex; align-items: center;
		overflow: hidden;
		position: relative;
	}
	.investments-list-item:last-child {
		margin-bottom: 0;
	}
	.investments-list-item.active {
		border: 4px solid #9ed347;
	}
	.investments-list-item.take {
		border: 4px solid #ffde2a;
	}
	.investments-item-content {
		margin-left: 50px;
		color: #fff;
	}
	.investments-item-name {
		font-weight: 700; font-size: 24px;
	}
	.investments-item-description {
		font-weight: 600; font-size: 18px;
		width: 500px;
		margin-top: 14px;
		line-height: 1.4;
	}
	.investments-item-time-wrapper {
		display: flex; align-items: center;
	}
	.investments-item-time {
		font-weight: 600; font-size: 16px;
		letter-spacing: 0.1em; text-transform: uppercase;
		color: hsla(0, 0%, 100%, 0.4);
		margin-top: 14px;
		display: flex;
	}
	.investments-item-time > span {
		font-weight: 600; font-size: 16px;
		letter-spacing: 0.1em; text-transform: uppercase;
		color: #fff;
		display: flex; align-items: center;
	}
	.investments-item-time > span::before {
		content: "";
		background: url('https://cdn.discordapp.com/attachments/928768829675429938/1016734881440596048/unknown.png');
		background-repeat: no-repeat; background-size: 100% 100%;
		width: 20px; height: 20px;
		margin-left: 15px; margin-right: 15px;
	}
	.investments-item-content-right {
		position: absolute;
		right: 0;
		display: flex; align-items: center;
	}
	.investments-item-profit {
		text-align: right;
		margin-right: 70px;
		display: flex; flex-direction: column; align-items: flex-end;
		color: #fff;
	}
	.investments-item-profit-val {
		text-transform: uppercase;
		font-weight: 600; font-size: 18px;
	}
	.investments-item-profit-val > span {
		font-size: 36px; font-weight: 700;
		display: block;
		margin-top: 6px;
	}
	.investments-item-profit-val-green {
		padding-left: 5px; padding-right: 5px;
		height: 22px; width: fit-content;
		background: linear-gradient(90deg, #9ed347, #7fa95e);
		border-radius: 6px;
		font-weight: 600; font-size: 18px;
		margin-top: 20px;
	}
	.investments-item-button {
		display: flex; justify-content: center; align-items: center;
		height: 100%; width: 290px;
	}
	.investments-item-button > button {
		height: 47px;
		display: flex; justify-content: center; align-items: center;
		padding-left: 26px; padding-right: 26px;
		border: 3px solid #ffde2a; border-radius: 300px;
		background: unset; color: #ffde2a;
		font-size: 18px; text-transform: uppercase; font-weight: 700;
		cursor: pointer;
	}
	.investments-item-button > button:hover {
		transform: translateX(-10px);
	}
	.investments-page-header-wrapper {
		display: flex; flex-direction: column; align-items: center;
	}
	.investments-page-days {
		margin-top: 32px;
		display: flex;
		color: #fff;
	}
	.investments-page-days > li {
		height: 40px; 
		padding-left: 18px; padding-right: 18px; margin-right: 12px;
		border: 3px solid #fff; border-radius: 300px;
		color: #fff;
		text-transform: uppercase; font-size: 24px; font-weight: 700;
		display: flex; justify-content: center; align-items: center;
	}
	.investments-item-progress {
		display: flex;
		align-items: center;
		text-transform: uppercase;
	}
	.investments-item-progress > p {
		font-size: 16px; font-weight: 600;
		text-align: right;
		line-height: 1.2;
		margin-top: 10px;
		color: #fff;
	}
	.investments-item-progress > p > span {
		display: block;
		color: #9ed347;
		font-size: 24px; font-weight: 700;
	}
	.investments-item-progressbar {
		height: 102px; width: 20px;
		position: relative;
		margin-left: 20px;
		display: flex; flex-direction: column;
	}
	.investments-item-progressbar > span.gray {
		position: absolute;
		left: 0; top: 0;
		background: hsla(0, 0%, 100%, 0.2);
		width: 100%;
		background: hsla(0, 0%, 100%, 0.2);
	}
	.investments-item-progressbar > span.green {
		position: absolute;
		left: 0; bottom: 0;
		background: #9ed347;
		width: 100%;
	}
	.investments-page-days > li.active {
		border-color: #ffde2a;
		color: #ffde2a;
	}
	.active-investments {
		width: 16vh; height: 12vh;
		background: linear-gradient(0deg, #65bc6a, rgba(101, 188, 106, 0));
		right:0; bottom: 0;
		position: absolute;
		margin-right: 1vw;
		display: flex; flex-direction: column; align-items: center;
	}
	.active-investments > p {
		font-size: 1.4vh; font-weight: 800; text-transform: uppercase;
		color: hsla(0, 0%, 100%, 0.4);
		letter-spacing: 0.05em;
		text-align: center;
		line-height: 1.2;
		transform: skewY(-4deg);
	}
	.active-investments > p > span {
		display: block;
		color: #fff;
		font-size: 2.4vh;
	}
	.active-investments > p > span.span {
		color: hsla(0, 0%, 100%, 0.4);
		font-size: 1.4vh;
	}
	.active-investments > img {
		position: absolute;
		bottom: -5.4vh;
		width: 14.3vh; height: 13.3vh;
	}
	.active-investments-text {
		position: absolute;
		bottom: 0.4vh;
		z-index: 1;
		width: 10.4vh; height: 4vh;
		left: 2.3vh;
		display: flex; justify-content: center; align-items: center;
		color: #fff;
		transform: skewY(-4deg);
	}
	.active-investments-text > p {
		font-weight: 800; font-size: 3vh;
	}
	::-webkit-scrollbar {
		width: 4px;
	}
	::-webkit-scrollbar-track {
		background: rgba(0, 0, 0, 0.2);
		border-radius: 10px;
	}
	::-webkit-scrollbar-thumb {
		border-radius: 10px;
		background: #24272d;
	}
</style>