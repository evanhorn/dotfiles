" Vim syntax file
" Language:	gmsh
" Creator:	CHAMPANEY Laurent laurent.champaney@meca.uvsq.fr
" Modification by PEPIN Fabrice shared through Gmsh mailing list.
" Based on Gmsh 3.0.6
"
" Installation :
" Add this file in ~/.vim/syntax/
"
" Add the following lines in your .vim/filetype.vim
" 	augroup filetypedetect
"	au! BufRead,BufNewFile *.geo		setfiletype gmsh
"	augroup END
"
" Add the following comment at the end of your other gmsh files
" // vim: set filetype=gmsh :  //

" Remove any old syntax stuff hanging around
syn clear
syn case ignore
" 
syn keyword gmshConditional	If EndIf
syn keyword gmshRepeat		For EndFor
syn keyword gmshFunction	Function Return
"
" Any integer
"syn match gmshNumber		"-\=\<\d\+\>"
" floating point number, with dot, optional exponent
"syn match gmshFloat		"\<\d\+\.\d*\([edED][-+]\=\d\+\)\=\>"
" floating point number, starting with a dot, optional exponent
"syn match gmshFloat		"\.\d\+\([edED][-+]\=\d\+\)\=\>"
" floating point number, without dot, with exponent
"syn match gmshFloat		"\<\d\+[edED][-+]\=\d\+\>"
"
syn keyword gmshOperator  = += -= *= /= : ...  /\ 
syn keyword gmshOperator  && ++ -- == != ~= <= >=
"
" Identifier
"syn match gmshIdentifier		"\<[a-zA-Z_][a-zA-Z0-9_]*\>"
"
" Comments
  syn region	gmshCommentL	start="//" skip="\\$" end="$" keepend contains=@gmshCommentGroup,gmshSpaceError
  syn region	gmshComment	matchgroup=gmshCommentStart start="/\*" matchgroup=NONE end="\*/" contains=@gmshCommentGroup,gmshCommentStartError,gmshSpaceError
syntax match	gmshCommentError	display "\*/"
syntax match	gmshCommentStartError display "/\*"me=e-1 contained
"
" Keywords
" Built-in functions
syn keyword gmshKeyword Acos Asin Atan Atan2 Ceil Cos Cosh Exp Fabs Fmod Fllor Hypot Log
syn keyword gmshKeyword Log10 Modulo Rand Round Sqrt Sin Sinh Tan Tanh
" Macros
syn keyword gmshKeyword Macro Return Call
" Loops and conditionals
syn keyword gmshKeyword For In EndFor If ElseIf Else EndIf 
" General commands
syn keyword gmshKeyword Pi newp newl news newv newll newsl newreg DefineConstant SetNumber SetString 
syn keyword gmshKeyword Abort Exit CreateDir Printf Error Merge ShapeFromFile Draw SetChanged BoundingBox
syn keyword gmshKeyword Delete Model Physicals Variables Options Print Sleep SystemCall NonBlockingSystemCall
syn keyword gmshKeyword OnelabRun SetName SetFactory SyncModel NewModel Include
" Geometry commands
syn keyword gmshKeyword Point Physical Line Bezier BSpline Spline Circle Ellipse Loop Wire Compound
syn keyword gmshKeyword Plane Surface Sphere Disk Rectangle Volume Sphere Box Cylinder Torus Cone
syn keyword gmshKeyword Wedge ThruSections Ruled Extrude Using Fillet Curve 
" Boolean operations & operations
syn keyword gmshKeyword BooleanIntersection BooleanUnion BooleanDifference BooleanFragments 
syn keyword gmshKeyword Dilate Rotate Symmetry Translate Boundary CombinedBoundary PointsOf 
syn keyword gmshKeyword Coherence Hide Show 
" Fields
syn keyword gmshKeyword Field Background Attractor AttractorAnisoCurve Ball BoundaryLayer 
syn keyword gmshKeyword Curvature Distance ExternalProcess Frustum Gradient IntersectAniso Laplacian 
syn keyword gmshKeyword LonLat MathEval MathEvalAniso Min Max MaxEigenHessian Mean MinAniso Octree 
syn keyword gmshKeyword Param PostView Restrict 
" Mesh
syn keyword gmshKeyword Structured Threshold Transfinite Progression Bump Left Right Alternate 
syn keyword gmshKeyword AlternateRight AlternateLeft TransfQuadTri Index ScaleLastLayer
syn keyword gmshKeyword Mesh RefineMesh OptimizeMesh AdaptMesh RelocateMesh SetOrder PartitionMesh
syn keyword gmshKeyword Periodic Affine SetPartition Color Recombine MeshAlgorithm Reverse Save
syn keyword gmshKeyword Smoother Homology Cohomology
" Post-processing
syn keyword gmshKeyword Alias AliasWithOptions CopyOptions ElementsByViewName ElementsFromAllViews
syn keyword gmshKeyword ElementsFromVisibleViews TimeStepsByViewName TimeSteps TimeStepsFromAllViews
syn keyword gmshKeyword TimeStepsFromVisibleViews Empty Views Plugin Run 
" General option list : note that some options are skip but you can add them
syn keyword gmshKeyword AxesFormatX AxesFormatY AxesFormatZ AxesLabelX AxesLabelY AxesLabelZ DefaultFileName 
syn keyword gmshKeyword Axes ColorScheme DetachedMenu DrawBoundingBoxes ExpertMode PointSize 
" Geometry option : note that some options are skip but you can add them
syn keyword gmshKeyword Geometry AutoCoherence LabelType Lines LineNumbers Normals Points PointNumbers 
syn keyword gmshKeyword PointType Surfaces SurfaceNumbers SurfaceType Volumes VolumeNumbers 
" Mesh option : note that some options are skip but you can add them
syn keyword gmshKeyword Algorithm Algorithm3D AngleSmoothNormals AnisoMax 
syn keyword gmshKeyword CharacteristicLengthExtendFromBoundary CharacteristicLengthFactor CharacteristicLengthMin 
syn keyword gmshKeyword CharacteristicLengthMax CharacteristicLengthFromCurvature CharacteristicLengthFromPoints 
syn keyword gmshKeyword ElementOrder Explode Format HighOrderNumLayers LabelType Light Lines LineNumbers 
syn keyword gmshKeyword MetisAlgorithm MetisEdgeMatching MetisRefinementAlgorithm MinimumCirclePoints 
syn keyword gmshKeyword MinimumCurvePoints Normals Optimize OptimizeThreshold OptimizeNetgen Partitioner 
syn keyword gmshKeyword Points PointNumbers Prisms Pyramids Trihedra Quadrangles QualityInf QualitySup  
syn keyword gmshKeyword QualityType RecombinationAlgorithm RecombineAll Recombine3DAll Recombine3DLevel 
syn keyword gmshKeyword Recombine3DConformity RemeshAlgorithm RemeshParametrization RefineSteps SaveAll 
syn keyword gmshKeyword SaveElementTagType SaveGroupsOfNodes SecondOrderIncomplete SecondOrderLinear 
syn keyword gmshKeyword Smoothing SubdivisionAlgorithm SurfaceEdges SurfaceFaces SurfaceNumbers Tetrahedra 
syn keyword gmshKeyword Triangles VolumeEdges VolumeFaces VolumeNumbers 

"
" because of Print.---- options
"syn match gmshPrint		"\<Print\>"
" Options
"syn match gmshOption2		"\<[a-zA-Z_]*\[\d\]\.[a-zA-Z0-9_]*\>"
"syn match gmshOptions		"\<[a-zA-Z_]*\.[a-zA-Z0-9_]*\>"
"
"if !exists("did_gmsh_syntax_inits")
"  let did_gmsh_syntax_inits = 1
  " The default methods for highlighting.  Can be overridden later
  hi link gmshStatement		Statement
  hi link gmshLabel		Special
  hi link gmshConditional	Conditional
  hi link gmshRepeat		Repeat
  hi link gmshFunction		Repeat
  hi link gmshTodo		Todo
  hi link gmshNumber		Number
  hi link gmshFloat		Float
  hi link gmshLogicalConstant	Constant
  hi link gmshCommentStart	Comment
  hi link gmshComment		Comment
  hi link gmshCommentL		Comment
  hi link gmshType		Type
  hi link gmshImplicit		Special
  hi link gmshPrint		Operator
  hi link gmshOperator		Type	
  hi link gmshKeyword		Operator
  hi link gmshIdentifier	Identifier
  hi link gmshPreCondit		PreCondit
  hi link gmshString		String
  hi link gmshOptions		PreProc
  hi link gmshOption2		PreProc
"endif
"
let b:current_syntax = "gmsh"
"
"EOF	vim: ts=8 noet tw=120 sw=8 sts=0
