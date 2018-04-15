package khaEC.misterpah;

import kha.Image;
import khaEC.Component;
import kha.graphics2.Graphics;

class Sprite extends Component{
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
	var image:Image;
	public var rect:Array<Float>;
	public var center:Array<Float>;
	var image_stack:Array<Image>;
	var image_current_index:Int;
	var image_is_animation:Bool;
	var animation_counter:Int;
	var animation_speed:Int;
	override public function new(_x:Float,_y:Float,_image:Dynamic){
		super();
		this.name = "Sprite";
		this.x = _x;
		this.y = _y;
		
		if (Reflect.hasField(_image,"image") == true){
			this.image = _image;
			image_is_animation = false;
		}
		else{
			image_is_animation = true;
			animation_counter = 0;
			image_current_index = 0;
			this.image_stack = _image;
			this.image = image_stack[image_current_index];
		}
		this.width = this.image.width;
		this.height = this.image.height;
	}

	public function set_animation_speed(counter:Int){
		animation_speed = counter;
	}

	function animation_selector(){
		animation_counter += 1;
		if (animation_counter >= animation_speed){
			animation_counter = 0;
			image_current_index += 1;
			if (image_current_index >= image_stack.length){
				image_current_index = 0;
			}
			
			this.image = image_stack[image_current_index];
		}
	}

	override public function update(){
		if (image_is_animation){
			animation_selector();
		}
		super.update();
	}

	public function set_center(_x:Float,_y:Float){
		this.x = _x + this.width/2;
		this.y = _y + this.height/2;
	}


	override public function render(g:Graphics){
		g.drawImage(this.image,this.x,this.y);
	}
	override function get(key:String){
		var value:Dynamic = 0;
		if (key == "x"){
			value = this.x;
		}
		if (key == "y"){
			value = this.y;
		}		
		return value;
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