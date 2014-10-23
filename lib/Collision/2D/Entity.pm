package Collision::2D::Entity;
use Mouse;

use overload '""'  => sub{'entity'};

has 'x' => (
   isa => 'Num',
   is => 'ro',
   #required => 1,
);
has 'y' => (
   isa => 'Num',
   is => 'ro',
   #required => 1,
);

has 'xv' => (
   isa => 'Num',
   is => 'ro',
   default => 0,
);
has 'yv' => (
   isa => 'Num',
   is => 'ro',
   default => 0,
);

has 'relative_x' => (
   isa => 'Num',
   is => 'rw',
);
has 'relative_y' => (
   isa => 'Num',
   is => 'rw',
);

has 'relative_xv' => (
   isa => 'Num',
   is => 'rw',
);
has 'relative_yv' => (
   isa => 'Num',
   is => 'rw',
);

sub normalize{
   my ($self, $other) = @_;
   $self->relative_x ($self->x - $other->x);
   $self->relative_y ($self->y - $other->y);
   $self->relative_xv ($self->xv - $other->xv);
   $self->relative_yv ($self->yv - $other->yv);
}

#an actual collision at t=0; 
sub null_collision{
   my $self = shift;
   my $other = shift;
   return Collision::2D::Collision->new(
      time => 0,
      ent1 => $self,
      ent2 => $other,
   );
}

no Mouse;
__PACKAGE__->meta->make_immutable;
1

__END__
=head1 NAME

Collision::2D::Entity - A moving entity. Don't use this directly.

=head1 DESCRIPTION

=head1 ATTRIBUTES

=head2 x,y,xv,yv

Absolute position and velocity in space.
These are necessary if you want to do collisions through 
L<dynamic_collision|Collision::2D/dynamic_collision>

 dynamic_collision($circ1, $circ2);

=head2 relative_x, relative_y, relative_xv, relative_yv

Relative position and velocity in space.
these are necessary if you want to do collisions directly through entity methods,

 $circ1->collide_circle($circ2);

In this case, both the absolute and relative position and velocity of $circ2
is not used. The relative attributes of $circ1 are assumed to be relative to $circ2.


=head1 METHODS

=head2 normalize

 $self->normalize($other); # $other isa entity
This compares the absolute attributes of $self and $other.
It only sets the relative attributes of $self.
This is necessary to call collide_*($other) methods on $self.
