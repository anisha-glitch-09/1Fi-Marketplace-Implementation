function calculateNoCostEmi(
  price,
  tenureMonths
) {
  return Math.ceil(
    price / tenureMonths
  );
}

function createEmiPlans(
  price,
  tenures
) {
  return tenures.map((tenure) => {
    const monthlyAmount =
      calculateNoCostEmi(
        price,
        tenure
      );

    return {
      tenureMonths: tenure,
      monthlyAmount,
      totalAmount: price,
      interest: 0,
      isNoCost: true
    };
  });
}

module.exports = {
  calculateNoCostEmi,
  createEmiPlans
};
