package haxerecast;

#if hl

typedef HaxeRecast = haxe.macro.MacroType<[webidl.Module.build({ idlFile : "Sources/haxerecast/recast.idl", autoGC : false, nativeLib : "recast" })]>;

#else
@:native('recast')
extern class Functions {
	// untyped recast.cb()
	public function OBJDataLoader(data:String, done:Void->Void):Void;
	public function buildSolo():Void;
	public function set_cellSize(val:Float):Void;
	public function set_cellHeight(val:Float):Void;
	public function set_agentHeight(val:Float):Void;
	public function set_agentRadius(val:Float):Void;
	public function set_agentMaxClimb(val:Float):Void;
	public function set_agentMaxSlope(val:Float):Void;
	// public function buildTiled():Void;
	public function getRandomPoint(callback:Dynamic):Void;
	// callback:Float->Float->Float
	public function findPath(from_x:Float, from_y:Float, from_z:Float, to_x:Float, to_y:Float, to_z:Float, max:Int, callback:Dynamic):Void;
	// callback:Array<{x, y, z}>
	// public function addAgent(options:Dynamic):Void;
}
#end