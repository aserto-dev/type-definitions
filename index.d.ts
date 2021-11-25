import { components as authorizerComponent } from './generated/authorizer'
import { components as tenantComponent } from './generated/tenant'
import { components as opcrComponent } from './generated/registry'

export type Definitions = authorizerComponent['schemas'] & tenantComponent['schemas'] & opcrComponent['schemas']
