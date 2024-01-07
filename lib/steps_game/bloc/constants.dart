const double arrowH = 56.0;
const double arrowW = 28.0;
const double arrowCoreWdt = arrowW / 2;
const double arrowEndToCore = (arrowW - arrowCoreWdt) / 2;
const double arrowClickedHgt = 0.5 * arrowH;
const double arrowReleasedHgt = 2.0 * arrowH;
const double radius = 1 / 15 * arrowH;

const double floorH = 0.2 * arrowH;
const double floorW = 1 * arrowW * 1.2;
const double floorWMini = 0.25 * arrowW;
const double floorWDef = floorW + floorWMini;
const double floorWLarge = floorW * 1.8;
const double floorWExt = 1 * floorW + floorWDef;

const double initialTop = 0.0;
const double initialLeft = 2 * arrowW;
const double equatorWidth = 5000.0;

const double firstTimeRatio = 3 / 4;
const double othersTimeRatio = 7 / 20;

const int maxSteps = 7;
