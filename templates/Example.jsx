import React from 'react'
import PropTypes from 'prop-types'

import './Example.scss'

const Example = ({ name }) => (
    <div className="example">
        <h1>Hello {name}</h1>
    </div>
)

Example.propTypes = {
    name: PropTypes.string
}
export default Example
