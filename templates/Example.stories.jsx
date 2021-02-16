import React from 'react'
import { text } from '@storybook/addon-knobs'

import Example from './Example'

export default { title: 'Example' }

export const withName = () => (
    <Example name={text('Name', 'Filip')} />
)

