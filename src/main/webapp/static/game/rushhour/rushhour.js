// level design from this version of the game: http://www.thinkfun.com/play-online/rush-hour/

var game = new Phaser.Game(750, 750, Phaser.AUTO, '', { preload: preload, create: create, update: update, });

var blocks,
		tiles,
		fieldSize = 6,
		gameArray = [],
		boundSprite,
		currentBlock,
		win,
		winText;

function preload () {
		game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
		game.load.baseURL = 'https://examples.phaser.io/assets/';
		game.load.crossOrigin = 'anonymous';
		game.load.image('box', 'sprites/block.png');
		game.load.image('platform', 'sprites/32x32.png');
}

function create () {
	game.grid = game.width / fieldSize;
	game.score = 0;
	game.physics.startSystem(Phaser.Physics.ARCADE);
	game.stage.backgroundColor = '#d3b787';
	
	tiles = game.add.physicsGroup();
	createTiles();
	win = game.add.sprite(game.grid * 5.5, game.grid * 2.5, 'platform');
	game.physics.arcade.enable(win);
	win.width = game.grid * .5;
	win.height = game.grid * .5;
	win.anchor.set(.5);
	
	blocks = game.add.physicsGroup();

	boundSprite = game.add.sprite(0, 0);
	boundSprite.width = 0;
	boundSprite.height = game.grid;
	
	createBlock(2, 0, 2, 1);
	createBlock(4, 0, 1, 3);
	createBlock(2, 2, 2, 1, true);
	createBlock(2, 4, 1, 2);
	createBlock(5, 4, 1, 2);
	
	winText = game.add.text(20, 20, '', {
		font: '40px helvetica',
		fill: '#eee' });

}

function createBlock(startCol, startRow, width, height, main) {
	var block = game.add.sprite(startCol * game.grid, startRow * game.grid, 'box');
	block.width = width * game.grid;
	block.height = height * game.grid;
	block.inputEnabled = true;
	block.input.enableDrag();
	block.input.enableSnap(game.grid, game.grid, false, true);
	if (width > height) {
		block.input.allowVerticalDrag = false;
	} else {
		block.input.allowHorizontalDrag = false;
	}
	if (main) {
			block.tint = 0x28b742;
	}
	blocks.add(block);
	block.events.onInputDown.add(onBlockDown, this);
	block.events.onInputUp.add(onBlockUp, this);
}

function onBlockDown(block) {
	var tile = getTileAtCoords(game.input.x, game.input.y);
	currentBlock = block;

	var row = Math.floor(tile.tileSprite.y / game.grid);
	var col = Math.floor(tile.tileSprite.x / game.grid);
	
	game.time.events.add(Phaser.Timer.SECOND * .05, function() {

		var bounds;
		
		if (block.input.allowVerticalDrag) {
			bounds = getVerticalBoundCols(row, col);
		} else {
			bounds = getHorizontalBoundCols(row, col);
		}

		boundSprite.width = bounds.width;
		boundSprite.height = bounds.height;
		boundSprite.x = bounds.x;
		boundSprite.y = bounds.y;

		block.input.boundsSprite = boundSprite;
		
	}, this);

}

function onBlockUp(block) {
	currentBlock = undefined;
	block.input.boundsSprite = null;
}

function getTileAtCoords(x, y) {
	var row = Math.floor(y / game.grid);
	var col = Math.floor(x / game.grid);
	return tileAt(row, col);
}

function update() {	
	tiles.forEach(function(t){
		t.occupied = false;
	});
	game.physics.arcade.overlap(blocks, tiles, overlapt, null, this);
	game.physics.arcade.overlap(blocks, win, winner, null, this);
	win.angle++;
}

function winner() {
	winText.text = 'You Won!';
}

function overlapt(block, tile) {
	if (block != currentBlock) {
		tile.occupied = true;
	} else {
		tile.occupied = false;
	}
}

function createTiles() {
		var key;
		var level = levels[0];
		for (var i = 0; i < level.length; i++) {
			gameArray[i] = [];
			for (var j = 0; j < level[i].length; j++) {
				if (level[i][j] === 'x') {
					key = 'platform';
				}
				else {
					key = 'box'
				}
					var tile = game.add.sprite(game.grid * j + game.grid / 2, game.grid * i + game.grid / 2, key);
					tile.width = game.grid * .5;
					tile.height = game.grid * .5;
					tile.alpha = 0;
					tile.anchor.set(0.5);
					tiles.add(tile);
			
					gameArray[i][j] = {
						key: key,
						tileSprite: tile
					}
		}
	}
}

function tileAt(row, col) {
	if (row < 0 || row >= fieldSize || col < 0 || col >= fieldSize) {
		return -1;
	}
	return gameArray[row][col];
}

function getHorizontalBoundCols(row, col) {
	var cols = 0;
	var exit = false;
	var startCol = col;
	var endCol = col;
	
	for (var i = col; i < fieldSize; i++) {
		if (!exit) {
			if (!tileAt(row, i).tileSprite.occupied) {
				endCol = i;
			} else {
				exit = true;
			}
		}
	}
	
	exit = false;
	for (var i = col - 1; i > -1; i--) {
		if (!exit) {
			if (!tileAt(row, i).tileSprite.occupied) {
				startCol = i;
			} else {
				exit = true;
			}
		}
	}
	
	var hBounds = {};
	hBounds.width = (endCol - startCol + 1) * game.grid;
	hBounds.height = game.grid;
	hBounds.x = startCol * game.grid;
	hBounds.y = row * game.grid;

	return hBounds;
	
}

function getVerticalBoundCols(row, col) {
	var rows = 0;
	var exit = false;
	var startRow = row;
	var endRow = row;
	
	for (var i = row; i < fieldSize; i++) {
		if (!exit) {
			if (!tileAt(i, col).tileSprite.occupied) {
				endRow = i;
			} else {
				exit = true;
			}
		}
	}
	
	exit = false;
	for (var i = row - 1; i > -1; i--) {
		if (!exit) {
			if (!tileAt(i, col).tileSprite.occupied) {
				startRow = i;
			} else {
				exit = true;
			}
		}
	}

	var vBounds = {};
	vBounds.width = game.grid;
	vBounds.height = (endRow - startRow + 1) * game.grid;
	vBounds.x = col * game.grid;
	vBounds.y = startRow * game.grid;

	return vBounds;
	
}

var levels = [
	[
		'xxxxxxxx',
		'xxxxxxxx',
		'xxxxxxxx',
		'xxxxxxxx',
		'xxxxxxxx',
		'xxxxxxxx'
	]
];