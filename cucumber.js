module.exports = {
  default: {
    require: ['src/support/*.ts', 'src/steps/*.ts'],
    requireModule: ['ts-node/register'],
    format: [
      'progress',
      'html:reports/cucumber-report.html',
      'json:reports/cucumber-report.json'
    ],
    paths: ['features/**/*.feature']
  }
};
