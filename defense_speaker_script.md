# Thesis Defense Speaker Script
## Study of Radioactive Source Monitoring Based on ElasticNet Regression Method
### Wang Kaiqi | April 2026

---

## Slide 1 — Title Page
Good morning/afternoon, respected professors and committee members. My name is Wang Kaiqi, from the Sino-French Institute of Nuclear Engineering and Technology. My thesis is titled "Study of Radioactive Source Monitoring Based on ElasticNet Regression Method," supervised by Professor Shi Wei from City University of Hong Kong and Professor Wang Kai from Sun Yat-sen University.

---

## Slide 2 — Outline
Here is the outline of my presentation. I will cover the research background, literature review, theoretical basis, algorithm implementation, PHITS Monte Carlo simulation, experimental results, and finally conclusions with future work.

---

## Slide 3 — Research Background
Nuclear facility decommissioning is a growing global challenge. The Fukushima Daiichi decommissioning has heightened the urgency of this issue. According to IAEA technical reports, accurate characterization of radioactive source distribution is a critical prerequisite for optimizing decommissioning plans, ensuring personnel safety, and minimizing waste.

In confined plant spaces, the radioactive sources present three-dimensional complexity: first, composite source types including localized hot-spots and continuous activation zones; second, nuclide diversity with different energy spectra; and third, strict measurement constraints due to limited detector positions and dose exposure limits.

---

## Slide 4 — Problem Statement
The core task is an inverse problem. The forward problem predicts detector readings given known sources. The inverse problem reconstructs the source distribution from limited detector measurements.

Mathematically, this is formulated as **d = A·s + ε**, where A is the contribution matrix, s is the source vector we want to recover, and ε is measurement noise.

This problem faces three challenges: it is underdetermined with fewer detectors than unknowns, it is ill-posed making solutions sensitive to noise, and it must handle both sparse hot spots and continuous activation regions simultaneously.

---

## Slide 5 — Literature Review: Method Comparison
This table compares existing methods. ML-EM and MPMI methods are computationally expensive and noise-sensitive. The global optimization approach IRT-DEGL has extremely high computational cost. LASSO excels at sparse source localization but over-compresses continuous regions to discrete points. Fused LASSO improves continuous region reconstruction but requires a predefined neighborhood graph and has high computational complexity.

ElasticNet combines excellent sparse localization with excellent continuous region reconstruction, and it has not yet been applied to nuclear source monitoring — this is the gap my thesis fills.

---

## Slide 6 — Why ElasticNet?
ElasticNet's advantages are supported by cross-domain evidence. In nuclear medicine imaging, dynamic ElasticNet outperforms pure L1, L2, and fixed-weight methods. In X-ray luminescence computed tomography, it achieves superior localization and dual-source resolution. In fluorescence molecular tomography, it reduces localization error by over 30 percent.

These results confirm that ElasticNet's L1-plus-L2 design has inherent superiority in handling the sparse-versus-continuous contradiction, which motivates its application to nuclear source monitoring.

---

## Slide 7 — ElasticNet Formulation
The ElasticNet objective function, proposed by Zou and Hastie in 2005, combines L1 and L2 penalties with two key hyperparameters: alpha controls overall regularization strength, and rho controls the L1-to-L2 mixing ratio.

The L1 penalty promotes sparsity by driving irrelevant coefficients to exactly zero — this enables hot-spot localization. The L2 penalty groups correlated variables and suppresses oscillation — this preserves continuous region morphology. When rho approaches 1, ElasticNet degrades to LASSO; when rho approaches 0, it degrades to Ridge regression.

Importantly, the objective function is strictly convex when lambda-2 is positive, guaranteeing a unique global minimum. This avoids the convergence issues that Fused LASSO faces with ADMM.

---

## Slide 8 — Physical Interpretation
The L1 penalty has a clear physical meaning: it acts as a count-type penalty on how many grid cells contain sources, making the solution tend toward a few concentrated non-zero elements — exactly what sparse hot-spot localization needs.

The L2 penalty suppresses individual coefficient amplitude and promotes neighboring cells to have similar values, enabling naturally smooth reconstruction inside continuous activation regions.

The synergy effect means: near sparse hotspots, L1 dominates for precise localization; inside continuous regions, L2 dominates for smooth morphology; and in transition zones, both cooperate for natural morphological transitions.

---

## Slide 9 — Algorithm Pipeline
The algorithm follows a three-stage pipeline. In preprocessing, we perform column normalization, non-negative SVD matrix construction, and condition number assessment. In optimization, we use ElasticNet with the positive=True parameter for hard non-negativity, GridSearchCV with 50 alpha values and 80 l1-ratio values, and 5-fold cross-validation. In post-processing, we denormalize the solution and apply non-negative truncation.

---

## Slide 10 — Column Normalization Results
[POINT TO FIGURE]
This figure shows the effect of column normalization. For condition number 100, all 5 independent runs achieve MSE between 10 to the minus 4 and 10 to the minus 9, demonstrating that column normalization is the essential numerical foundation for all subsequent optimizations.

---

## Slide 11 — Non-negative Constraint Enhancement
[POINT TO FIGURE]
This shows the combined non-negative SVD matrix with non-negative ElasticNet optimization. Experiments 1 and 3 reach MSE of 10 to the minus 9, demonstrating that the triple mechanism of non-negativity, sparse selection, and smooth anti-noise works effectively.

---

## Slide 12 — Intercept Fitting Analysis
[POINT TO FIGURES]
On the left is a good case where the intercept is small and reconstruction is accurate. On the right is a bad case where the intercept dominates, causing reconstruction degradation. This reveals that ElasticNet has an upper limit of noise tolerance — beyond this limit, neither with nor without intercept fitting gives good results.

---

## Slide 13 — PHITS Simulation Configuration
PHITS is a Monte Carlo particle transport code developed by JAEA. Our simulation uses 10 to the 8th power particles across 100 batches, with 10 Cs-137 point sources emitting 0.662 MeV gamma rays, distributed in a spherical space of 10-meter radius centered on the reactor.

The floor is divided into a 4-by-3 grid of 12 cells. 8 spherical detectors are positioned around the perimeter. The resulting contribution matrix is 8 by 12, with only 11 out of 96 elements being non-zero, and a numerical rank of only 6 out of 8.

---

## Slide 14 — Source-Detector Geometry
[POINT TO FIGURE]
This figure shows the grid division and source-detector layout. The 10 simulated radioactive fragments, following a log-normal distance distribution, are mapped to 12 grid cells. 8 detectors are distributed around the perimeter. The contribution matrix has significant blind spots due to this geometry.

---

## Slide 15 — PHITS Validation Results
The best parameters found are alpha equals 10 to the minus 6 and l1-ratio equals 0.99. ElasticNet successfully detected all 7 non-zero cells with no missed detections. 5 out of 7 cells have relative error below 2 percent — cells 1, 7, 8, 9, and 10 are reconstructed with excellent accuracy.

---

## Slide 16 — Reconstruction Visualization
[POINT TO FIGURES]
On the left, we see the true versus estimated source distribution. The matched results are clearly visible. On the right is the contribution matrix heatmap, showing the sparse structure — most elements are zero, with only a few detector-cell pairs having meaningful response.

---

## Slide 17 — Error Source Analysis
Cells 5 and 6 have large errors — 99.3 percent and 98.1 percent respectively. However, this is NOT an algorithm failure. Cell 6 has only one detector responding with an extremely weak signal at the 10 to the minus 9 level. Cell 5 similarly has only one weak detector response.

The matrix rank analysis reveals the root cause: the numerical rank is only 6 out of 8, meaning only 6 of the 12 cells are algebraically distinguishable. The remaining cells' information is physically lost in the detector response. Improved detector layout would directly resolve these errors.

---

## Slide 18 — Condition Number Impact
[POINT TO FIGURE]
This figure compares four optimization strategies: adaptive CV, segmented search, multi-segment grid search, and the fusion strategy. A key finding is the existence of difficulty inflection points at condition numbers approximately 150 and 300, where noise amplification is most severe.

---

## Slide 19 — Bayesian Optimization Results
[POINT TO FIGURES]
On the left are Bayesian optimization results for sparse source reconstruction. On the right is the Bayesian method validated with the PHITS contribution matrix. Bayesian optimization converges within 10 to 15 iterations, saving 70 to 90 percent computation compared to grid search, though its accuracy ceiling at high condition numbers is slightly lower.

---

## Slide 20 — Grid Search vs. Bayesian Optimization
Grid search and Bayesian optimization are complementary, not substitutive. Grid search provides higher accuracy ceiling through exhaustive evaluation, while Bayesian optimization offers 5 to 10 times faster convergence, ideal for rapid iteration and auto-tuning scenarios. Notably, the optimal l1-ratio is consistently approximately 0.99 across all conditions, confirming that this inverse problem has a strong inherent sparsity structure.

---

## Slide 21 — Conclusions
To summarize: First, ElasticNet fills the application gap in nuclear source monitoring by effectively handling sparse-plus-continuous composite reconstruction. Second, our optimization strategies — column normalization, adaptive alpha, non-negative constraint, and intercept penalty — significantly improve accuracy for condition numbers 100 to 300. Third, PHITS validation confirms practical value: all 7 non-zero cells detected, 5 with error below 2 percent. Fourth, condition number inflection points at 150 and 300 are identified. And fifth, Bayesian optimization complements grid search with 70 to 90 percent computation savings.

---

## Slide 22 — Future Work
Looking forward, mobile detection platforms such as UGVs and UAVs can carry detectors for large-scale autonomous patrol, enriching the contribution matrix and reducing the condition number. Algorithm improvements include adaptive ElasticNet, Bayesian ElasticNet with uncertainty quantification, and deep learning model cascade. Extended applications include multi-energy source discrimination, 3D volumetric reconstruction, and real-time online reconstruction.

---

## Slide 23 — References
These are the key references for this work. The most important are Zou and Hastie's original ElasticNet paper from 2005, and the LASSO-based source reconstruction works by Professor Shi Wei and the JAEA team.

---

## Slide 24 — Q&A
That concludes my presentation. Thank you for your attention. I welcome any questions and discussion.

---

## Preparation Tips:
- **Total speaking time**: aim for 15-20 minutes
- **Pace**: ~1 minute per content slide, ~30 seconds for figure slides
- **Key slides to emphasize**: Slide 15 (results table), Slide 17 (error analysis — shows critical thinking)
- **Anticipated questions**:
  1. "Why not just use more detectors?" → Physics/space constraints; UGV/UAV is the future direction
  2. "How does ElasticNet compare to deep learning?" → DL needs large training data; ElasticNet works with limited measurements
  3. "What about real-world validation?" → Current work is simulation-based; next step is field deployment
  4. "Why is l1_ratio so close to 1?" → The true source distribution is inherently sparse; L1 dominance is physically correct
  5. "Can this handle multiple nuclides?" → The framework is extensible; spectral ElasticNet can distinguish nuclides by energy
