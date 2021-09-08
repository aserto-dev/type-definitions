import typescript from '@rollup/plugin-typescript';

export default {
  input: 'index.ts',
  output: {
    dir: 'output',
    format: 'cjs',
  },
  plugins: [typescript()]
};
