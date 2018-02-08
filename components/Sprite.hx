package components;
import kha.Image;
import khaEC.Component;
import kha.graphics2.Graphics;

class Sprite extends Component{
	var x:Float;
	var y:Float;
	var w:Float;
	var h:Float;
	var image:Image;
	public var rect:Array<Float>;
	public var center:Array<Float>;
	override public function new(_x:Float,_y:Float,_image:Image){
		super();
		this.name = "Sprite";
		this.x = _x;
		this.y = _y;
		this.image = _image;
		this.w = this.image.width;
		this.h = this.image.height;
		rect = [x,y,x+w,y+h];
		center = [x+(w/2),y+(h/2)];
	}

	override public function update(){
		super.update();
		rect = [x,y,x+w,y+h];
		center = [x+(w/2),y+(h/2)];
	}

	public function set_center(x:Float,y:Float){
		this.x = x - (w/2);
		this.y = y - (h/2);
	}

	override public function render(g:Graphics){
		g.drawImage(this.image,this.x,this.y);
		//g.drawSubImage(this.image,x,y,10,10,50,50);
	}

	override function set(key:String, value:Dynamic){
		if (key == "x"){
			this.x = value;
		}
		if (key == "y"){
			this.y = value;
		}
		if (key == "image"){
			this.image = value;
		}
	}
}