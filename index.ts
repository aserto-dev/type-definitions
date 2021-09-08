import { components as authorizerComponent } from './generated/authorizer'
import { components as tenantComponent } from './generated/tenant'

export type Definitions = authorizerComponent['schemas'] & tenantComponent['schemas']