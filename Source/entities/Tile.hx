package entities;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Reinier
 */

class Tile extends Sprite
{
	private var size:Float;
	private var state:GamePlayState;
	
	public var isSet:String;
	
	private var ghostCircle:Circle;
	private var ghostCross:Cross;
	private var circle:Circle;
	private var cross:Cross;
	
	public function new(x:Float, y:Float, size:Float, state:GamePlayState)
	{
		super();
		this.x = x;
		this.y = y;
		this.size = size;
		this.state = state;
		
		isSet = "";
		
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	private function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		
		graphics.beginFill(0, 0);
		graphics.drawRect(0, 0, size, size);
		graphics.endFill();
		
		ghostCircle = new Circle(0, 0, size * .5, 10, 0, .1, false);
		ghostCross = new Cross(0, 0, size, 10, 0, .1, false);
		ghostCircle.visible = false;
		ghostCross.visible = false;
		addChild(ghostCircle);
		addChild(ghostCross);
		
		circle = new Circle(0, 0, size * .5, 10, 0x4FDFC2, 1, true, 1, onAnimationComplete);
		cross = new Cross(0, 0, size, 10, 0xFF8000, 1, true, 1, onAnimationComplete);
		
		addButtonListeners();
	}
	
	public function addButtonListeners():Void
	{
		buttonMode = true;
		addEventListener(MouseEvent.MOUSE_OVER, showGraphic);
		addEventListener(MouseEvent.MOUSE_OUT, hideGraphic);
		addEventListener(MouseEvent.CLICK, chooseGraphic);
	}
	
	public function removeButtonListeners():Void
	{
		buttonMode = false;
		removeEventListener(MouseEvent.MOUSE_OVER, showGraphic);
		removeEventListener(MouseEvent.MOUSE_OUT, hideGraphic);
		removeEventListener(MouseEvent.CLICK, chooseGraphic);
	}
	
	private function showGraphic(e):Void
	{
		if (state.turn % 2 == 0)
		{
			ghostCircle.visible = true;
		}
		else
		{
			ghostCross.visible = true;
		}
	}
	
	private function hideGraphic(e):Void
	{
		ghostCircle.visible = false;
		ghostCross.visible = false;
	}
	
	private function chooseGraphic(e = null):Void
	{
		removeButtonListeners();
		
		removeChild(ghostCircle);
		removeChild(ghostCross);
		
		if (state.turn % 2 == 0)
		{
			addChild(circle);
			isSet = "O";
		}
		else
		{
			addChild(cross);
			isSet = "X";
		}
		
		dispatchEvent(new Event("TILE_ACTIVE"));
	}
	
	private function onAnimationComplete()
	{
		state.drawWinLine();
	}
}