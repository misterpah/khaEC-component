package components;
import khaEC.Component;
import khaEC.Entity;
class Movement extends Component{
	var cur_entity:Entity;
	var endpoint:Array<Float>;
	var velocity:Array<Float>;
	var editMode:Bool;
	override public function new(entity:Entity,velocity:Array<Float>){
		super();
		editMode = false;
		cur_entity = entity;
		this.endpoint = [-1,-1];
		this.velocity = velocity;
		this.name = "Movement";
	}

	public function move_to(x:Float,y:Float){
		this.endpoint = [x,y];
	}

	override public function update(){
		var cur_sprite;
		if (editMode == true){return;}
		cur_sprite = cur_entity.getComponent("Sprite");
		if (endpoint != [-1,-1]){
			if (cur_sprite.x > endpoint[0]){
				cur_sprite.x -= this.velocity[0];
			}
			if (cur_sprite.x < endpoint[0]){
				cur_sprite.x += this.velocity[0];
			}
			if (cur_sprite.y > endpoint[1]){
				cur_sprite.y -= this.velocity[1];
			}
			if (cur_sprite.y < endpoint[1]){
				cur_sprite.y += this.velocity[1];
			}
		}
		if (rangeCheck(endpoint[0],cur_sprite.x-10,cur_sprite.x+10) && rangeCheck(endpoint[1],cur_sprite.y-10,cur_sprite.y+10)){
			//endpoint = [-1,-1];
		}		
	}

	function rangeCheck(check:Float,min:Float,max:Float){
		if ((check >= min) && (check < max)){
			return true;
		}
		else{
			return false;
		}
	}

	override function set(key:String, value:Dynamic){
		if (key == "editMode"){
			this.editMode = value;
		}
	}	
}