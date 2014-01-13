package tests.FP 
{
	import asunit.framework.TestCase;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	/**
	 * 
	 * @author Sean Snyder
	 */
	public class TestAnchorTo extends TestCase 
	{
		
		public function TestAnchorTo(testMethod:String=null) 
		{
			super(testMethod);
		}
		
		public function testBasicAnchoring():void {
			var entity:Entity = new Entity(0, 0);
			var anchor:Entity = new Entity(10, 10);
			
			FP.anchorTo(entity, anchor);
			assertTrue("Entity should have same x position as Anchor", entity.x == anchor.x);
			assertTrue("Entity should have same y position as Anchor", entity.y == anchor.y);
			
			anchor.moveBy(5, 5);
			assertTrue("Anchor should have changed x position", entity.x != anchor.x);
			assertTrue("Anchor should have changed y position", entity.y != anchor.y);
			
			FP.anchorTo(entity, anchor);
			assertTrue("Entity should have same x position as Anchor", entity.x == anchor.x);
			assertTrue("Entity should have same y position as Anchor", entity.y == anchor.y);
			
			entity.moveBy(5, 5);
			assertTrue("Entity should have changed x position", entity.x != anchor.x);
			assertTrue("Entity should have changed y position", entity.y != anchor.y);
			
			
			FP.anchorTo(entity, anchor);
			assertTrue("Entity should have same x position as Anchor", entity.x == anchor.x);
			assertTrue("Entity should have same y position as Anchor", entity.y == anchor.y);
		}
		
		public function testAnchoringWithDistance():void {
			var entity:Entity = new Entity(0, 0);
			var anchor:Entity = new Entity(100, 100);
			var maxDistance:Number = 10;
			var entityPrevX:Number = entity.x;
			var entityPrevY:Number = entity.y;
			
			FP.anchorTo(entity, anchor, maxDistance);
			assertTrue("Entity should have changed x position since beyond max distance", entity.x != entityPrevX);
			assertTrue("Entity should have changed y position since beyond max distance", entity.y != entityPrevY);
			assertTrue("Entity should be about the max distance away from anchor", entity.distanceFrom(anchor) == maxDistance);
			
			anchor.moveBy(-1, -1);
			entity.moveBy(1, 1);
			entityPrevX = entity.x;
			entityPrevY = entity.y;
			FP.anchorTo(entity, anchor, maxDistance);
			assertTrue("Entity should not have changed x position since within max distance", entity.x == entityPrevX);
			assertTrue("Entity should not have changed y position since within max distance", entity.y == entityPrevY);
		}
	}

}