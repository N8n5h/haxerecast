// Recast Navigation for Haxe
// https://github.com/recastnavigation/recastnavigation
// https://github.com/vincent/recast.js

package haxerecast;

class Recast {

	var hrecast:haxerecast.HaxeRecast.Functions;

	public function new() {
		#if js
		hrecast = untyped __js__("(1, eval)('this').recast");
		#end
	}

	public function OBJDataLoader(data:String, done:Void->Void):Void {
		#if js
		hrecast.OBJDataLoader(data, done);
		#else
		hrecast.OBJDataLoader(data);
		done();
		#end
	}

	public function settings(s:Config):Void {
		hrecast.set_cellSize(s.cellSize);
		hrecast.set_cellHeight(s.cellHeight);
		hrecast.set_agentHeight(s.agentHeight);
		hrecast.set_agentRadius(s.agentRadius);
		hrecast.set_agentMaxClimb(s.agentMaxClimb);
		hrecast.set_agentMaxSlope(s.agentMaxSlope);
	}

	public function buildSolo():Void {
		hrecast.buildSolo();
	}

	public function getRandomPoint(callback:Float->Float->Float->Void):Void {
		#if js
		hrecast.getRandomPoint(untyped recast.cb(callback));
		#else
		// HaxeRecast.getRandomPoint(callback);
		#end
	}

	public function findPath(from_x:Float, from_y:Float, from_z:Float, to_x:Float, to_y:Float, to_z:Float, max:Int, callback:Array<RecastWaypoint>->Void):Void {
		#if js
		hrecast.findPath(from_x, from_y, from_z, to_x, to_y, to_z, max, untyped recast.cb(callback));
		#else

		var ar:Array<RecastWaypoint> = [];
		hrecast.findPath(from_x, from_y, from_z, to_x, to_y, to_z, max);
		var pathLen:Int = Math.round(hrecast.pathLen);
		for (pathI in 0...Std.int(pathLen / 3)) {
			var x:Float = hrecast.pathData[pathI * 3 + 0];
			var y:Float = hrecast.pathData[pathI * 3 + 1];
			var z:Float = hrecast.pathData[pathI * 3 + 2];
			var p:RecastWaypoint = { x: x, y: y, z: z }
			ar.push(p);
		}
		/*
		var pathLen:Int = untyped __cpp__('HaxeRecast::pathLen');
		for (pathI in 0...Std.int(pathLen / 3)) {
			var x:Float = untyped __cpp__('HaxeRecast::pathData[pathI * 3]');
			var y:Float = untyped __cpp__('HaxeRecast::pathData[pathI * 3 + 1]');
			var z:Float = untyped __cpp__('HaxeRecast::pathData[pathI * 3 + 2]');
			var p:RecastWaypoint = { x: x, y: y, z: z }
			ar.push(p);
		}
		*/
		callback(ar);
		#end
	}
}

typedef Config = {
	public var cellSize:Float;
	public var cellHeight:Float;
	public var agentHeight:Float;
	public var agentRadius:Float;
	public var agentMaxClimb:Float;
	public var agentMaxSlope:Float;
}

typedef RecastWaypoint = {
	public var x:Float;
	public var y:Float;
	public var z:Float;
}
