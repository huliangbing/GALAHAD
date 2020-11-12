% test galahad_arc
% Nick Gould for GALAHAD productions 14/March/2017

clear control inform

%[ x, inform ] = galahad_arc( x0, 'rosenbrock_f', 'rosenbrock_g', ...
%                             'rosenbrock_h' )

%  set default control values

[ control ] = galahad_arc( 'initial' ) ;
control.print_level = 0 ;

% Rosenbrock problem (dense Hessian)

%  solve with default values

x0 = [ -1.2 1 ];
[ x, inform ]  = galahad_arc( 'existing', x0, 'rosenbrock_f', ...
                              'rosenbrock_g', 'rosenbrock_h' ) ;

disp( sprintf( 'Rosenbrock: \n%s %13.6e %s %8.4e %s %2.0f %s %2.0f', ...
      ' - arc: final f =', inform.obj, ...
      '- ||g|| =', inform.norm_g, ...
      '- iter =', inform.iter, ...
      '- status =', inform.status ) )

%  solve with direct solution of the subproblems

control.subproblem_direct = 1;
%control.print_level = 1;
[ x, inform ]  = galahad_arc( 'existing', x0, 'rosenbrock_f', ...
                              'rosenbrock_g', 'rosenbrock_h', control ...
                              ) ;
disp( sprintf( '%s %13.6e %s %8.4e %s %2.0f %s %2.0f', ...
      ' - arc: final f =', inform.obj, ...
      '- ||g|| =', inform.norm_g, ...
      '- iter =', inform.iter, ...
      '- status =', inform.status ) )

galahad_arc( 'final' )

% Tridiagonal problem (sparse Hessian)

[ control ] = galahad_arc( 'initial' ) ;

%  solve with default values

x0 = [ 4 3 2 ];
pattern_h = [ 1 1 ; 2 1 ; 2 2 ; 3 2 ; 3 3 ];
[ x, inform ]  = galahad_arc( 'existing', x0, 'tridia_f', ...
                              'tridia_g', 'tridia_h', pattern_h ) ;

disp( sprintf( 'Tridia: \n%s %13.6e %s %8.4e %s %2.0f %s %2.0f', ...
      ' - arc: final f =', inform.obj, ...
      '- ||g|| =', inform.norm_g, ...
      '- iter =', inform.iter, ...
      '- status =', inform.status ) )

%  solve with direct solution of the subproblems

control.subproblem_direct = 1;
%control.print_level = 1;
[ x, inform ]  = galahad_arc( 'existing', x0, 'tridia_f', ...
                              'tridia_g', 'tridia_h', pattern_h, ...
                              control ) ;
disp( sprintf( '%s %13.6e %s %8.4e %s %2.0f %s %2.0f', ...
      ' - arc: final f =', inform.obj, ...
      '- ||g|| =', inform.norm_g, ...
      '- iter =', inform.iter, ...
      '- status =', inform.status ) )

galahad_arc( 'final' )
