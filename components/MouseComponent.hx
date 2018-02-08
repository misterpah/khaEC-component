package components;
import khaEC.Component;
import khaEC.Entity;
class MouseComponent extends Component{
	var sprite:Entity;
	var rect:Array<Float>;
	var center:Array<Float>;
	override public function new(sprite:Entity){
		super();
		this.name = "MouseComponent";
		this.sprite = sprite;
	}

	override public function update(){
		super.update();
		var m = this.sprite.getComponent("Sprite");
		rect = m.rect;
		center = m.center;
	}

	public function mouse_interact(x:Int,y:Int){
		if ((x > rect[0]) && (x < rect[2])){
			if ((y > rect[1]) && (y < rect[3])){
				return true;
			}
		}
		return false;
	}
}