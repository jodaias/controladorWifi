import React from 'react';
import InputMask from 'react-input-mask';

const Input = (props) => (
  <InputMask
    mask={props.mask}
    value={props.value}
    onChange={props.onChange}
    id={props.id}
    name={props.name}
    type={props.type}
    placeholder={props.placeholder}
    required={props.required}
  />
);

export default Input;