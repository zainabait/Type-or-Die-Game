#ifndef MOVE_NODE_2D_H
#define MOVE_NODE_2D_H

#include <Godot.hpp>
#include <Node2D.hpp>

namespace godot {
	class MoveNode2D : public Node2D {
		GODOT_CLASS(MoveNode2D, Node2D)

	public:
		static void _register_methods();

		void _init(); // Called when the object is initialized
		void _process(float delta); // Called every frame

	private:
		Vector2 velocity;
	};
}

#endif // MOVE_NODE_2D_H
