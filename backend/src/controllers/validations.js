const Joi = require('joi');

const userSchema = Joi.object({
  nome: Joi.string()
    .min(3)
    .max(60)
    .required(),

  email: Joi.string()
    .email({ minDomainSegments: 2, tlds: { allow: ['com', 'net'] } }),

  whatsapp: Joi.string().min(10).max(11).pattern(/^[0-9]+$/).required(),
})

module.exports = {
  userSchema
}