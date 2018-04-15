package khaEC.misterpah;
import khaEC.Component;

// nape import
import nape.space.Space;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.shape.Circle;
import kha.graphics2.Graphics;
using kha.graphics2.GraphicsExtension;


class KhaNape extends Component{
	public var space:Space;
	public var objectBody:Body;
	public var objectRect:Polygon;
	public var objectCircle:Circle;
	public var shapeType:String;
	public var size:Array<Float>;
	public var drag_coefficient:Float;

	override public function new(_space:Space){
		super();
		this.name = "KhaNape";
		space = _space;
		objectBody = new Body();
		objectBody.space = space;
		shapeType = "";
		drag_coefficient = 0.95;
	}
	public function setStatic(){
		objectBody.type = BodyType.STATIC;
	}
	public function setImpulse(x:Float,y:Float){
		objectBody.applyImpulse(new Vec2(x,y));
	}
	public function update_xy(x:Float,y:Float){
		// since nape position reference is the center of object,
		// and kha position reference is at top right,
		// offset is calculated
		var offset_x:Float = -1;
		var offset_y:Float = -1;
		if (shapeType == "rectangle"){
			var bound = objectRect.body.bounds;
			offset_x = x+bound.width/2;
			offset_y = y+bound.height/2;
		}
		if (shapeType == "triangle"){
			var bound = objectRect.body.bounds;
			offset_x = x;
			offset_y = y;
		}		
		if (shapeType == "circle"){
			var bound = objectCircle.body.bounds;
			offset_x = x+bound.width/2;
			offset_y = y+bound.height/2;			
		}
		objectBody.position.set(new Vec2(offset_x,offset_y));
	}
	public function circle(radius:Float){
		objectCircle = new Circle(radius);
		size = [radius];
		objectCircle.body = objectBody;
		objectBody.shapes.add(objectCircle);
		shapeType = "circle";
	}
	public function rectangle(width:Float,height:Float){
		objectRect = new Polygon(Polygon.box(width,height));
		size = [width,height];
		objectRect.body = objectBody;
		objectBody.shapes.add(objectRect);
		shapeType = "rectangle";
	}
	public function triangle(width:Float,height:Float,shape:String){
		var polygon_shape = new Array<Vec2>();
		if (shape == "tl"){
			polygon_shape.push(new Vec2(0,0));
			polygon_shape.push(new Vec2(width,0));
			polygon_shape.push(new Vec2(0,height));
		}
		if (shape == "dr"){
			polygon_shape.push(new Vec2(width,0));
			polygon_shape.push(new Vec2(width,height));
			polygon_shape.push(new Vec2(0,height));
		}		
		objectRect = new Polygon(polygon_shape);
		size = [width,height];
		objectRect.body = objectBody;
		objectBody.shapes.add(objectRect);
		shapeType = "triangle";
	}	
	function impulseDrag(){
		objectBody.velocity.x *= drag_coefficient;
		objectBody.velocity.y *= drag_coefficient;
	}
	override public function update(){
		super.update();
		impulseDrag();
		space.step(1/60); // dt should be here
	}
	override public function render(g:Graphics){
		super.render(g);
		if (shapeType == "rectangle"){
			var bound = objectRect.body.bounds;
			var center_x = bound.x;
			var center_y = bound.y;
			g.drawRect(center_x, center_y,bound.width,bound.height);
		}
		if (shapeType == "triangle"){
			var bound = objectRect.body.bounds;
			var center_x = bound.x;
			var center_y = bound.y;
			g.drawRect(center_x, center_y,bound.width,bound.height);
		}		
		if (shapeType == "circle"){
			var bound = objectCircle.body.bounds;
			var center_x = bound.x + bound.width/2;
			var center_y = bound.y + bound.height/2;
			g.drawCircle(center_x, center_y, size[0]);
		}
	}
}