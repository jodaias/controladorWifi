const Joi = require('joi');

const userSchema = Joi.object({
  nome: Joi.string()
    .min(3)
    .max(60)
    .required(),

  email: Joi.string()
    .email({ minDomainSegments: 2, tlds: { allow: ['com', 'net'] } }),

  whatsapp: Joi.string().min(14).max(15).required(),
})

module.exports = {
  userSchema
}