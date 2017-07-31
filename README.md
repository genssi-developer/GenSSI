GenSSI 2.0 - Generating Series for testing Structural Identifiability

GenSSI 2.0 is a software toolbox for structural identifiability analysis of linear and nonlinear ODE models. It couples the generating series approach with identifiability tableaus (Chiş, et al., 2011a). Using Lie derivatives of the ODE model, a system of equations is generated, the solvability properties of which provide information about global and local structural identifiability as well as non-identifiability (Chiş et al., PLoS ONE, 2011b). The results are provided as text and visualised.
The implementation of GenSSI 2.0 is more efficient than that of earlier versions (Chiş et al., Bioinformatics, 2011) and provides the following functionalities:- An import for the SBML models is provided to facilitate the application of structural identifiability analysis in systems biology. This import exploits functionalities of the MATLAB toolbox SBMLimporter (https://github.com/ICB-DCM/SBMLimporter) and libSBML (Bornstein, et al., 2008).- Routines for multi-experiment structural identifiability analysis are provided. These routines allow the analysis of structural identifiability if observation under multiple experimental conditions, e.g. different inputs or initial states, are available.- Routines for state and parameter transformations are implemented to facilitate the removal of non-identifiable parameters and rescaling the variables. To accelerate the symbolic calculations, a routine for the automatic reformulations of ODEs with rational right-hand sides to ODEs with polynomial right-hand sides is provided (Ohtsuka, IEEE Transactions Automatic Control, 2005).- Routines for structural identifiability analysis and calculation of identifiability tableaus.
- Visualisation routines for identifiability plateaus.

References:
[1] Chiş, O.-T., Banga, J.R. and Balsa-Canto, E. (2011) Structural Identifiability of Systems Biology Models: A Critical Comparison of Methods, PLoS ONE, 6, e27755.
[2] Chiş, O.-T., Banga, J.R. and Balsa-Canto, E. (2011) GenSSI: a software toolbox for structural identifiability analysis of biological models, Bioinformatics, 27, 2610-2611.

This software is available under the <a href="http://www.opensource.org/licenses/bsd-license.php" target="_blank">BSD license</a>
 
=====================================

Copyright (c) 2016, Oana-Teodora Chiş, Julio R. Banga, Eva Balsa-Canto, Thomas S. Ligon, Fabian Fröhlich and Jan Hasenauer.
All rights reserved.
 
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
1) Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2) Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
