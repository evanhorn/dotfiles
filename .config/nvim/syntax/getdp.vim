" Vim syntax file
" Language:     GetDP
" Maintainer:   Patricio Toledo <patoledo@ing.uchile.cl>
" Last Change:  Mon 30 Mar 2020 11:29:25 AM CDT

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

let c_no_curly_error = 1

" Read the C syntax to start with
runtime! syntax/c.vim
unlet b:current_syntax

"Mismatcher
syn match getdpSpecial display contained "\\\(x\x\+\|\o\{1,3}\|.\|$\)"
if !exists("c_no_utf")
  syn match getdpSpecial display contained "\\\(u\x\{4}\|U\x\{8}\)"
endif
syn match getdpFormat display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlL]\|ll\)\=\([bdiuoxXDOUfeEgGcCsSpn]\|\[\^\=.[^]]*\]\)" contained
syn match getdpFormat display "%%" contained
syn region getdpString start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=getdpSpecial,getdpFormat,@Spell extend

"syn region getdpParen matchgroup=Identifier start="(" end=")" contains=ALLBUT,cParenError fold
"syn region getdpBrace matchgroup=Identifier start="{" end="}" contains=ALLBUT,cBraceError fold
"syn region getdpBracket matchgroup=Identifier start="\[" end="]" contains=ALLBUT,cBracketError fold
syn match cErrInParen display contained "^^<%\|^%>"
syn match cErrInBracket display contained "[);{}]\|<%\|%>"

syn match getdpArgument "\$\(\d\|\w\)\+"
syn match getdpLogicalOperator "[||]"
syn match getdpLogicalOperator "[&&]"
syn match getdpNumber "\<\d\+\(\.\d*\)\=\([edED][-+]\=\d\+\)\=[ij]\=\>"
syn match getdpNumber "\.\d\+\([edED][-+]\=\d\+\)\=[ij]\=\>"
syn match getdpNumber "\<\d\+[ij]\=\>"
syn match getdpRegister "\#\d"
syn match getdpRelationalOperator "[<>]=\="
syn match getdpRelationalOperator "[!]="

syn keyword getdpBasisFunction BF_CurlGroupOfPerpendicularEdge
syn keyword getdpBasisFunction BF_dGlobal BF_NodeX BF_NodeY BF_NodeZ
syn keyword getdpBasisFunction BF_DivPerpendicularFacet BF_Region
syn keyword getdpBasisFunction BF_GradNode BF_CurlEdge BF_DivFacet
syn keyword getdpBasisFunction BF_GroupOfEdges BF_CurlGroupOfEdges
syn keyword getdpBasisFunction BF_GroupOfNodes BF_GradGroupOfNodes
syn keyword getdpBasisFunction BF_GroupOfPerpendicularEdge
syn keyword getdpBasisFunction BF_Node BF_Edge BF_Facet BF_Volume
syn keyword getdpBasisFunction BF_PerpendicularEdge BF_CurlPerpendicularEdge
syn keyword getdpBasisFunction BF_PerpendicularFacet
syn keyword getdpBasisFunction BF_RegionX BF_RegionY BF_RegionZ BF_Global
syn keyword getdpBasisFunction BF_Zero BF_One AliasOf AssociatedWith
syn keyword getdpConstraint Assign Init AssignFromResolution
syn keyword getdpConstraint InitFromResolution Network Link LinkCplx
syn keyword getdpCurrent $DTime $integer $Iteration $Theta $Time
syn keyword getdpCurrent $TimeStep $X $XS $Y $YS $Z $ZS $A $B $C
syn keyword getdpDefine DefineConstant DefineGroup DefineFunction
syn keyword getdpElement Line Triangle Quadrangle Tetrahedron Hexahedron
syn keyword getdpElement Prism Pyramid Point
syn keyword getdpFormulation Dof Dt DtDof DtDt DtDtDof JacNL NeverDt
syn keyword getdpFormulation FemEquation FemEquation Galerkin deRham Local
syn keyword getdpFormulation Global Integral LocalQuantity Symmetry
syn keyword getdpFunction Complex Re Vector Tensor TensorV TensorSym TensorDiag
syn keyword getdpFunction CompX CompY CompZ
syn keyword getdpFunction CompXX CompXY CompYZ
syn keyword getdpFunction CompYX CompYY CompYZ
syn keyword getdpFunction CompZX CompZY CompZZ
syn keyword getdpFunction List ListAlt StrCat
syn keyword getdpFunctionSpace Form0 Form1 Form2 Form3 Form1P Form2P Scalar
syn keyword getdpFunctionSpace SubSpace
syn keyword getdpFunction X Y Z XYZ
syn keyword getdpGreen Laplace GradLaplace Helmholtz GradHelmholtz
syn keyword getdpGroup DualEdgesOf DualFacetsOf DualVolumesOf
syn keyword getdpGroup EdgesOfTreeIn FacetsOfTreeIn
syn keyword getdpGroup FacetsOfVolumesOf ElementsOf GroupsOfNodesOf
syn keyword getdpGroup GroupsOfEdgesOf GroupsOfEdgesOnNodesOf
syn keyword getdpGroup Region Global NodesOf EdgesOf
syn keyword getdpInclude Include
syn keyword getdpIntegration Gauss GaussLegendre
syn keyword getdpJacobian VolAxiRectShell VolAxiSquRectShell
syn keyword getdpJacobian VolAxiSphShell VolAxiSquSphShell VolRectShell
syn keyword getdpJacobian Vol Sur Lin VolAxi SurAxi VolAxiSqu VolSphShell
syn keyword getdpMath Atan2 Sinh Cosh Tanh Fabs Fmod Cross Hypot Norm
syn keyword getdpMathFunction Exp Log Log10 Sqrt Sin Asin Cos Acos Atan
syn keyword getdpMathFunction F_Period SquNorm
syn keyword getdpMathFunction Unit Transpose TTrace F_Cos_wt_p F_Sin_wt_p
syn keyword getdpMiscFunction dInterpolationAkima Order
syn keyword getdpMiscFunction dInterpolationLinear InterpolationAkima
syn keyword getdpMiscFunction F_CompElementNum InterpolationLinear
syn keyword getdpMiscFunction Printf Normal NormalSource
syn keyword getdpName BasisFunction Entity Quantity Equation Operation
syn keyword getdpName NameOfCoef NameOfConstraint NameOfFormulation
syn keyword getdpName NameOfMesh NameOfPostProcessing NameOfSpace
syn keyword getdpName Name Type Case NameOfResolution NameOfBasisFunction
syn keyword getdpName NameOfSystem System
syn keyword getdpObject Group Function Constraint FunctionSpace
syn keyword getdpObject Jacobian Integration Formulation Resolution
syn keyword getdpObject PostProcessing PostOperation
syn keyword getdpPostOperation ChangeOfValues GmshGmshParsed Table
syn keyword getdpPostOperation Depth Skin Smoothing HarmonicToTime Dimension
syn keyword getdpPostOperation OnElementsOf OnRegion OnGlobal OnSection
syn keyword getdpPostOperation OnGrid OnPoint OnLine OnPlane OnBox File
syn keyword getdpPostOperation Sort Iso NoNewLine ChangeOfCoordinates
syn keyword getdpPostOperation TimeStep Frequency Format Adapt Target Value
syn keyword getdpPostOperation TimeTable Gnuplot Adaptation
syn keyword getdpPostProcessing Local Integral
syn keyword getdpResolution FourierTransform TimeLoopTheta TimeLoopNewmark
syn keyword getdpResolution GenerateSeparate Update InitSolution
syn keyword getdpResolution Generate Solve GenerateJac SolveJac
syn keyword getdpResolution IterativeLoop
syn keyword getdpResolution SaveSolution SaveSolutions TransferSolution
syn keyword getdpResolution SystemCommand If Else Print Lanczos
syn keyword getdpResolution TransferInitSolution SetTime SetFrequency
syn keyword getdpSpec Not All

" Define the default highlighting.
if !exists("did_getdp_syntax_inits")
  let did_getdp_syntax_inits = 1

  " hi def link cFormat None
  " hi def link cCppString None
  " hi def link cCommentL None
  " hi def link cCommentStart None
  hi def link cLabel None
  " hi def link cUserLabel None
  hi def link cConditional None
  hi def link cRepeat None
  " hi def link cCharacter None
  " hi def link cSpecialCharacter None
  hi def link cOctalZero None
  hi def link cOperator None
  hi def link cStructure None
  hi def link cStorageClass None
  hi def link cInclude None
  hi def link cPreProc None
  hi def link cDefine None
  hi def link cStatement None
  hi def link cPreCondit None
  hi def link cType None
  hi def link cConstant None
  " hi def link cSpecial SpecialChar
  " hi def link cTodo None
  hi def link cBadContinuation Error
  hi def link cCppOutSkip None
  hi def link cCppInElse2 None
  hi def link cCppOutIf2 None
  hi def link cCppOut None

  hi def link getdpArgument String
  hi def link getdpBasisFunction Type
  hi def link getdpColon Special
  hi def link getdpCommentStart Comment
  hi def link getdpComment Comment
  hi def link getdpCommentL Comment
  hi def link getdpConstant Operator
  hi def link getdpConstraint Type
  hi def link getdpCurrent String
  hi def link getdpDefine Type
  hi def link getdpElement Type
  hi def link getdpParenError Error
  hi def link getdpBraceError Error
  hi def link getdpBracketError Error
  hi def link getdpFormulation Type
  hi def link getdpFunction Function
  hi def link getdpFunctionSpace Type
  hi def link getdpGreen Type
  hi def link getdpGroup Type
  hi def link getdpInclude Include
  hi def link getdpIntegration Type
  hi def link getdpJacobian Type
  hi def link getdpLogicalOperator Operator
  hi def link getdpMath Function
  hi def link getdpMathFunction Function
  hi def link getdpMiscFunction Function
  hi def link getdpName Operator
  hi def link getdpNumber Number
  hi def link getdpObject Structure
  hi def link getdpPostOperation Type
  hi def link getdpPostProcessing Type
  hi def link getdpRegister String
  hi def link getdpRelationalOperator Operator
  hi def link getdpRepeat Repeat
  hi def link getdpResolution Type
  hi def link getdpSpec Underlined
  hi def link getdpString String
endif

let b:current_syntax = "getdp"
